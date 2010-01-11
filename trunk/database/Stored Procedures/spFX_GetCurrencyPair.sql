/* =============================================
 * spFX_GetCurrencyPair
 * File: spFX_GetCurrencyPair.sql
 * 
 * Desc: Returns info related to a specific currency pair.
 * =============================================
 */

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spFX_GetCurrencyPair' 
)
   DROP PROCEDURE dbo.spFX_GetCurrencyPair
GO

CREATE PROCEDURE dbo.spFX_GetCurrencyPair
	@base as nvarchar(3), @quote as nvarchar(3)
AS
	SELECT id, base, quote, boughtsold_level, inactive
	from currencypairs where base = @base and quote = @quote
GO

grant execute on dbo.spFX_GetCurrencyPair to TRADEJOURNAL_GRP
