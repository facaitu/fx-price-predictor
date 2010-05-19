/* =============================================
 * spFX_TransferStagedEvent
 * File: spFX_TransferStagedEvent.sql
 * 
 * Desc: Add new event from staging
 * =============================================
 */

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spFX_TransferStagedEvent' 
)
   DROP PROCEDURE dbo.spFX_TransferStagedEvent
GO

CREATE PROCEDURE dbo.spFX_TransferStagedEvent
	@steventid as nvarchar(10), @err_no as int output, @err_desc as nvarchar(255) output
AS
	
	-- Is staged event id valid?
	if (select count(eventid) from fxevents_staging where eventid = @steventid) = 0
	begin
		select @err_no = 1001
		select @err_desc = err_desc from fxerrors where err_no = @err_no
	end
	-- Transfer event.
	else
	begin
		declare @name as nvarchar(50)
		declare @recurring as tinyint
		declare @next_date as date
		declare @next_time as time
		declare @importance as smallint
		declare @previous as numeric(19,5)
		declare @watch as tinyint
		declare @currency as nchar(3)

		select @name = name, @recurring = recurring, @next_date = next_date, @next_time = next_time,
			@importance = importance, @previous = previous, @watch = watch, @currency = currency
			from vFX_EventsStaging where eventid = @steventid
		
		begin transaction transferEvent
			exec spFX_AddEvent @eventid = @steventid, @name = @name, @recurring = @recurring, @next_date = @next_date,
				@next_time = @next_time, @importance = @importance, @previous = @previous, @watch = @watch,
				@currency = @currency, @err_no = @err_no, @err_desc = @err_desc
			
			if @@ERROR > 0
			begin
				select @err_no = @@ERROR
			end
			else if @err_no > 0
			begin
				rollback transaction transferEvent
			end
			else
			begin
				exec spFX_DelEventStaging @eventid = @steventid, @err_no = @err_no, @err_desc = @err_desc

				if @@ERROR > 0
				begin
					select @err_no = @@ERROR
				end
				else if @err_no > 0
				begin
					rollback transaction transferEvent
				end
			end
		
			commit transaction transferEvent
	end
	
if @err_no > 0 
	return 1
else
	return 0
	
GO

grant execute on dbo.spFX_TransferStagedEvent to TRADEJOURNAL_GRP
