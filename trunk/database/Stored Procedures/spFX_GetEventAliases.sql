/* =============================================
 * spFX_GetEventAliases
 * File: spFX_GetEventAliases.sql
 * 
 * Desc: Returns event aliases.
 * =============================================
 */

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spFX_GetEventAliases' 
)
   DROP PROCEDURE dbo.spFX_GetEventAliases
GO

CREATE PROCEDURE dbo.spFX_GetEventAliases
	@eventid as int
AS
	SELECT ea.eventid, es.name as event_name, ea.name as alias_name
	from fxevent_aliases ea
	left join fxevents es
		on ea.eventid = es.id
	where ea.eventid = @eventid
GO

grant execute on dbo.spFX_GetEventAliases to TRADEJOURNAL_GRP
