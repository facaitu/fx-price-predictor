/* =============================================
 * spFX_AddEventStaging
 * File: spFX_AddEventStaging.sql
 * 
 * Desc: Add new event
 * =============================================
 */

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spFX_AddEventStaging' 
)
   DROP PROCEDURE dbo.spFX_AddEventStaging
GO

CREATE PROCEDURE dbo.spFX_AddEventStaging
	@eventid as nvarchar(10), @name as nvarchar(50), @recurring as tinyint, @next_date as date,
	@next_time as time, @importance as smallint, @previous as numeric(19,5), @watch as tinyint, @currency as nchar(3),
	@err_no as int output, @err_desc as nvarchar(255) output
AS
	
	-- Is event id valid?
	if (select count(eventid) from fxevents_staging where eventid = @eventid) > 0
	begin
		select @err_no = 1001
		select @err_desc = err_desc from fxerrors where err_no = @err_no
	end
	-- Is currency valid?
	if (select count(id) from currencies where currency = @currency) = 0
	begin
		select @err_no = 2103
		select @err_desc = err_desc from fxerrors where err_no = @err_no
	end
	-- Add event.
	else
	begin
		insert into fxevents_staging (eventid, name, recurring, next_date, next_time, importance, previous, watch, currency)
		values (@eventid, @name, @recurring, @next_date, @next_time, @importance, @previous, @watch, @currency)
		
		if @@ERROR > 0
		begin
			select @err_no = @@ERROR
		end
	end
	
if @err_no > 0 
	return 1
else
	return 0
	
GO

grant execute on dbo.spFX_AddEventStaging to TRADEJOURNAL_GRP
