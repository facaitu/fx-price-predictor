/* =============================================
 * spFX_AddEventTransaction
 * File: spFX_AddEventTransaction.sql
 * 
 * Desc: Add new event transaction
 * =============================================
 */

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spFX_AddEventTransaction' 
)
   DROP PROCEDURE dbo.spFX_AddEventTransaction
GO

CREATE PROCEDURE dbo.spFX_AddEventTransaction
	@eventid as nvarchar(10), @ignore_watch as tinyint = 0,
	@err_no as int output, @err_desc as nvarchar(255) output
AS
	
	-- Is this event watchable?
	if @ignore_watch = 0 and (select watch from fxevents where eventid = @eventid) = 0
	begin
		select @err_no = 1021
		select @err_desc = err_desc from fxerrors where err_no = @err_no
	end
	-- Is a transaction for this event already open?
	else if (select COUNT(id) from fxevent_transactions where eventid = @eventid) > 0
	begin
		select @err_no = 1022
		select @err_desc = err_desc from fxerrors where err_no = @err_no
	end
	-- Add event transaction
	else
	begin
		insert into fxevent_transactions (eventid, name, eventdate, eventtime, importance, previous, forecast, actual, currency)
		select eventid, name, next_date, next_time, importance, previous, 0, 0, currency
		from fxevents where eventid = @eventid
	
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

grant execute on dbo.spFX_AddEventTransaction to TRADEJOURNAL_GRP
