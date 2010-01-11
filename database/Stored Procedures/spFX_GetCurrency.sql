/* =============================================
 * spFX_GetCurrency
 * File: spFX_GetCurrency.sql
 * 
 * Desc: Returns info related to a specific currency.
 * =============================================
 */

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spFX_GetCurrency' 
)
   DROP PROCEDURE dbo.spFX_GetCurrency
GO

CREATE PROCEDURE dbo.spFX_GetCurrency
	@currency as nvarchar(3)
AS
	SELECT id, currency, name, lastmodified
	from currencies where currency = @currency
GO

grant execute on dbo.spFX_GetCurrency to TRADEJOURNAL_GRP
