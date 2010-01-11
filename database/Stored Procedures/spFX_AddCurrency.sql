/* =============================================
 * spFX_AddCurrency
 * File: spFX_AddCurrency.sql
 * 
 * Desc: Add new currency
 * =============================================
 */

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spFX_AddCurrency' 
)
   DROP PROCEDURE dbo.spFX_AddCurrency
GO

CREATE PROCEDURE dbo.spFX_AddCurrency
	@currency as nvarchar(3), @name as nvarchar(50) = '',
	@err_no as int output, @err_desc as nvarchar(255) output
AS
	
	-- Does currency exist?
	if (select count(id) from currencies where currency = @currency) > 0
	begin
		select @err_no = 2101
		select @err_desc = err_desc from fxerrors where err_no = @err_no
	end
	-- Add currency.
	else
	begin
		insert into currencies (currency, name, lastmodified)
		values (@currency, @name, GETDATE())
		
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

grant execute on dbo.spFX_AddCurrency to TRADEJOURNAL_GRP
