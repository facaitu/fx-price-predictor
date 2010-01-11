/* =============================================
 * spFX_DelCurrencyPair
 * File: spFX_DelCurrencyPair.sql
 * 
 * Desc: Delete currency pair.
 * =============================================
 */

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spFX_DelCurrencyPair' 
)
   DROP PROCEDURE dbo.spFX_DelCurrencyPair
GO

CREATE PROCEDURE dbo.spFX_DelCurrencyPair
	@base as nvarchar(3), @quote as nvarchar(3),
	@err_no as int output, @err_desc as nvarchar(255) output
AS
	
	-- Does currency pair exist?
	if (select count(id) from currencypairs where base = @base and quote = @quote) = 0
	begin
		select @err_no = 2003
		select @err_desc = err_desc from fxerrors where err_no = @err_no
	end
	-- Is currency pair assigned to any events?
	if (select count(id) from fxevent_currencypairs where base = @base and quote = @quote) > 0
	begin
		select @err_no = 1205
		select @err_desc = err_desc from fxerrors where err_no = @err_no
	end
	-- Add currency pair.
	else
	begin
		delete from currencypairs where base = @base and quote = @quote
		
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

grant execute on dbo.spFX_DelCurrencyPair to TRADEJOURNAL_GRP
