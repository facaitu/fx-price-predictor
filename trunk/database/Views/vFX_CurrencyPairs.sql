/* =============================================
 * vFX_CurrencyPairs
 * File: vFX_CurrencyPairs.sql
 * 
 * Desc: Returns currency pair.
 * ============================s=================
 */

IF object_id(N'dbo.vFX_CurrencyPairs', 'V') IS NOT NULL
	DROP VIEW dbo.vFX_CurrencyPairs
GO

CREATE VIEW dbo.vFX_CurrencyPairs AS

	SELECT id, base, quote, boughtsold_level, inactive
	from currencypairs
GO

grant select on dbo.vFX_CurrencyPairs to TRADEJOURNAL_GRP
