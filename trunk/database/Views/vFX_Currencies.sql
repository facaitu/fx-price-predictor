/* =============================================
 * vFX_Currencies
 * File: vFX_Currencies.sql
 * 
 * Desc: Returns currency.
 * ============================s=================
 */

IF object_id(N'dbo.vFX_Currencies', 'V') IS NOT NULL
	DROP VIEW dbo.vFX_Currencies
GO

CREATE VIEW dbo.vFX_Currencies AS

	SELECT id, currency, name, lastmodified
	from currencies
GO

grant select on dbo.vFX_Currencies to TRADEJOURNAL_GRP
