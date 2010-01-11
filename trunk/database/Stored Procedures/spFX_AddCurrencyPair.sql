/* =============================================
 * spFX_AddCurrencyPair
 * File: spFX_AddCurrencyPair.sql
 * 
 * Desc: Add currency pair
 * =============================================
 */

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spFX_AddCurrencyPair' 
)
   DROP PROCEDURE dbo.spFX_AddCurrencyPair
GO

CREATE PROCEDURE dbo.spFX_AddCurrencyPair
	@base as nvarchar(3), @quote as nvarchar(3), @boughtsold_level as numeric(1,1),
	@inactive as tinyint, @lastmodified as datetime,
	@err_no as int output, @err_desc as nvarchar(255) output
AS
	
	-- Does currency pair exist?
	if (select count(id) from currencypairs where base = @base and quote = @quote) > 0
	begin
		select @err_no = 2001
		select @err_desc = err_desc from fxerrors where err_no = @err_no
	end
	-- Is each a valid currency?
	else if (select COUNT(id) from currencies where currency in (@base,@quote)) < 2
		 or @base = @quote
	begin
		select @err_no = 2004
		select @err_desc = err_desc from fxerrors where err_no = @err_no
	end
	-- Add currency pair.
	else
	begin
		insert into currencypairs (base, quote, boughtsold_level, inactive, lastmodified)
		values (@base, @quote, @boughtsold_level, @inactive, GETDATE())
		
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

grant execute on dbo.spFX_AddCurrencyPair to TRADEJOURNAL_GRP
