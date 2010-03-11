/* =============================================
 * vFX_EventAliases
 * File: vFX_EventAliases.sql
 * 
 * Desc: Returns event aliases.
 * ============================s=================
 */

IF object_id(N'dbo.vFX_EventAliases', 'V') IS NOT NULL
	DROP VIEW dbo.vFX_EventAliases
GO

CREATE VIEW dbo.vFX_EventAliases AS

	SELECT ep.eventid, ep.name as event_name, ea.name as alias_name
	, 0 as err_no, '' as err_desc
	from fxevent_aliases ea
	left join fxevents ep
		on ea.eventid = ep.id

GO

grant select on dbo.vFX_EventAliases to TRADEJOURNAL_GRP
