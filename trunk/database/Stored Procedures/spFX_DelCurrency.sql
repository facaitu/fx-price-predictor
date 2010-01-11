/* =============================================
 * spFX_DelCurrency
 * File: spFX_DelCurrency.sql
 * 
 * Desc: Delete currency
 * =============================================
 */

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spFX_DelCurrency' 
)
   DROP PROCEDURE dbo.spFX_DelCurrency
GO

CREATE PROCEDURE dbo.spFX_DelCurrency
	@currency as nvarchar(3),
	@err_no as int output, @err_desc as nvarchar(255) output
AS
	
	-- Does currency exist?
	if (select count(id) from currencies where currency = @currency) = 0
	begin
		select @err_no = 2103
		select @err_desc = err_desc from fxerrors where err_no = @err_no
	end
	-- Delete currency.
	else
	begin
		delete from currencies where currency = @currency
		
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

grant execute on dbo.spFX_DelCurrency to TRADEJOURNAL_GRP
