/* =============================================
 * spFX_CloseEventTransaction
 * File: spFX_CloseEventTransaction.sql
 * 
 * Desc: Close event transaction
 * =============================================
 */

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spFX_CloseEventTransaction' 
)
   DROP PROCEDURE dbo.spFX_CloseEventTransaction
GO

CREATE PROCEDURE dbo.spFX_CloseEventTransaction
	@eventid as nvarchar(10), @ignore_date as tinyint = 0, @status as int = 0,
	@err_no as int output, @err_desc as nvarchar(255) output
AS
	
	-- Is this transaction closeable?
	if @ignore_date = 0 and 
		((select eventdate from fxevent_transactions where eventid = @eventid) < CONVERT (date, GETDATE())
			and (select eventtime from fxevent_transactions where eventid = @eventid) < CONVERT (time, GETDATE()))

	begin
		select @err_no = 1023
		select @err_desc = err_desc from fxerrors where err_no = @err_no
	end
	-- Close event transaction
	else
	begin 
		begin tran close_trx
	
		-- Insert event into transactions history table 
		insert into fxevent_transactions_history (eventid, name, eventdate, eventtime, importance, previous, forecast, actual, currency)
		select eventid, name, eventdate, eventtime, importance, previous, forecast, actual, currency
		from fxevent_transactions where eventid = @eventid
		
		-- Update event setup previous value if the date has passed
		if ((select eventdate from fxevent_transactions where eventid = @eventid) > CONVERT (date, GETDATE())
			and (select eventtime from fxevent_transactions where eventid = @eventid) > CONVERT (time, GETDATE()))
			update fxevents set previous = etrx.actual
			from fxevent_transactions etrx inner join fxevents evt on evt.eventid = etrx.eventid
			where evt.eventid = @eventid
		
		-- Delete from transactions table
		delete from fxevent_transactions where eventid = @eventid
		
		commit tran close_trx
		
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

grant execute on dbo.spFX_CloseEventTransaction to TRADEJOURNAL_GRP
