/* =============================================
 * spFX_GetEventIndicators
 * File: spFX_GetEventIndicators.sql
 * 
 * Desc: Returns event indicators.
 * =============================================
 */

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spFX_GetEventIndicators' 
)
   DROP PROCEDURE dbo.spFX_GetEventIndicators
GO

CREATE PROCEDURE dbo.spFX_GetEventIndicators
	@eventid as int
AS
	SELECT ea.ind_id, es.name as ind_name, es.currency, es.importance, es.next_date
	, es.next_time, es.previous, es.recurring, ea.ind_order, ea.ind_importance
	, ea.ind_positive_threshhold, ea.ind_positive_threshhold_weight, ea.ind_negative_threshhold
	, ea.ind_negative_threshhold_weight, ea.eventid, ep.name as event_name
	from fxevent_associations ea
	left join fxevents es
		on ea.ind_id = es.id
	left join fxevents ep
		on ea.eventid = ep.id
	where ea.eventid = @eventid
GO

grant execute on dbo.spFX_GetEventIndicators to TRADEJOURNAL_GRP
