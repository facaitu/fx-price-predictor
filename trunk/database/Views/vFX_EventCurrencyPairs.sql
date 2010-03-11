/* =============================================
 * vFX_EventCurrencyPairs
 * File: vFX_EventCurrencyPairs.sql
 * 
 * Desc: Returns indicators.
 * ============================s=================
 */

IF object_id(N'dbo.vFX_EventCurrencyPairs', 'V') IS NOT NULL
	DROP VIEW dbo.vFX_EventCurrencyPairs
GO

CREATE VIEW dbo.vFX_EventCurrencyPairs AS

	SELECT ecp.eventid, ecp.cp_id, evt.name, cp.base, cp.quote, cp.boughtsold_level, cp.inactive
	, 0 as err_no, '' as err_desc
	from fxevent_currencypairs ecp
	left join fxevents evt
		on ecp.eventid = evt.id
	left join currencypairs cp
		on ecp.cp_id = cp.id

GO

grant select on dbo.vFX_EventCurrencyPairs to TRADEJOURNAL_GRP
