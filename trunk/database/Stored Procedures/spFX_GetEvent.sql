/* =============================================
 * spFX_GetEvent
 * File: spFX_GetEvent.sql
 * 
 * Desc: Returns events
 * =============================================
 */

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spFX_GetEvent' 
)
   DROP PROCEDURE dbo.spFX_GetEvent
GO

CREATE PROCEDURE dbo.spFX_GetEvent
	@eventid as int
AS
	SELECT evt.eventid, evt.name, evt.recurring, evt.next_date, evt.next_time, evt.importance
		, evt.previous, evt.watch, evt.currency
	from fxevents evt
	where evt.eventid = @eventid
GO

grant execute on dbo.spFX_GetEvent to TRADEJOURNAL_GRP
