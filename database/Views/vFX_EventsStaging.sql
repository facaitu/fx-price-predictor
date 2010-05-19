/* =============================================
 * vFX_EventsStaging
 * File: vFX_EventsStaging.sql
 * 
 * Desc: Returns indicators.
 * ============================s=================
 */

IF object_id(N'dbo.vFX_EventsStaging', 'V') IS NOT NULL
	DROP VIEW dbo.vFX_EventsStaging
GO

CREATE VIEW dbo.vFX_EventsStaging AS

	SELECT evt.id, evt.eventid, evt.name, evt.recurring, evt.next_date, evt.next_time, evt.importance
		, evt.previous, evt.watch, evt.currency, 0 as err_no, '' as err_desc
	from fxevents_staging evt

GO

grant select on dbo.vFX_EventsStaging to TRADEJOURNAL_GRP
