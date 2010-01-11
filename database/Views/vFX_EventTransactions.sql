/* =============================================
 * vFX_EventTransactions
 * File: vFX_EventTransactions.sql
 * 
 * Desc: Returns indicators.
 * ============================s=================
 */

IF object_id(N'dbo.vFX_EventTransactions', 'V') IS NOT NULL
	DROP VIEW dbo.vFX_EventTransactions
GO

CREATE VIEW dbo.vFX_EventTransactions AS

	SELECT etrx.eventid, etrx.name, etrx.eventdate, etrx.eventtime, etrx.previous
		, etrx.forecast, etrx.actual, etrx.currency
	from fxevent_transactions etrx
	left join fxevents evt
		on etrx.eventid = evt.eventid

GO

grant select on dbo.vFX_EventTransactions to TRADEJOURNAL_GRP
