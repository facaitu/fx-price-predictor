/* =============================================
 * vFX_EventIndicators
 * File: vFX_EventIndicators.sql
 * 
 * Desc: Returns indicators.
 * ============================s=================
 */

IF object_id(N'dbo.vFX_EventIndicators', 'V') IS NOT NULL
	DROP VIEW dbo.vFX_EventIndicators
GO

CREATE VIEW dbo.vFX_EventIndicators AS

	SELECT ea.ind_id, es.name as ind_name, es.currency, es.importance, es.next_date
	, es.next_time, es.previous, es.recurring, ea.ind_order, ea.ind_importance
	, ea.ind_positive_threshhold, ea.ind_positive_threshhold_weight, ea.ind_negative_threshhold
	, ea.ind_negative_threshhold_weight, ea.eventid, ep.name as event_name
	, 0 as err_no, '' as err_desc
	from fxevent_associations ea
	left join fxevents es
		on ea.ind_id = es.id
	left join fxevents ep
		on ea.eventid = ep.id

GO

grant select on dbo.vFX_EventIndicators to TRADEJOURNAL_GRP
