/* =============================================
 * spFX_DelEventCurrencyPair
 * File: spFX_DelEventCurrencyPair.sql
 * 
 * Desc: Delete event currency pair.
 * =============================================
 */

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spFX_DelEventCurrencyPair' 
)
   DROP PROCEDURE dbo.spFX_DelEventCurrencyPair
GO

CREATE PROCEDURE dbo.spFX_DelEventCurrencyPair
	@eventid as nvarchar(10), @base as nchar(3), @quote as nchar(3)
	, @err_no as int output, @err_desc as nvarchar(255) output
AS
	
	-- Is currency pair valid?
	if (select count(id) from currencypairs where base = @base and quote = @quote) = 0
	begin
		select @err_no = 2003
		select @err_desc = err_desc from fxerrors where err_no = @err_no
	end
	-- Is event id valid?
	else if (select count(eventid) from fxevents where eventid = @eventid) = 0
	begin
		select @err_no = 1003
		select @err_desc = err_desc from fxerrors where err_no = @err_no
	end
	-- Is this currency pair NOT assigned to this event?
	else if (select count(cp_id) from fxevent_currencypairs where eventid = @eventid and base = @base and quote = @quote) = 0
	begin
		select @err_no = 1203
		select @err_desc = err_desc from fxerrors where err_no = @err_no
	end
	-- Delete currency pair from event.
	else
	begin
		delete from fxevent_currencypairs where eventid = @eventid and base = @base and quote = @quote
	
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

grant execute on dbo.spFX_DelEventCurrencyPair to TRADEJOURNAL_GRP
