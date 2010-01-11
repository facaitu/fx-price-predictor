/* =============================================
 * vFX_Events
 * File: vFX_Events.sql
 * 
 * Desc: Returns indicators.
 * ============================s=================
 */

IF object_id(N'dbo.vFX_Events', 'V') IS NOT NULL
	DROP VIEW dbo.vFX_Events
GO

CREATE VIEW dbo.vFX_Events AS

	SELECT evt.eventid, evt.name, evt.recurring, evt.next_date, evt.next_time, evt.importance
		, evt.previous, evt.watch, evt.currency
	from fxevents evt

GO

grant select on dbo.vFX_Events to TRADEJOURNAL_GRP
