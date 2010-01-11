/* =============================================
 * spFX_GetEventCurrencyPairs
 * File: spFX_GetEventCurrencyPairs.sql
 * 
 * Desc: Returns event currency pairs
 * =============================================
 */

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spFX_GetEventCurrencyPairs' 
)
   DROP PROCEDURE dbo.spFX_GetEventCurrencyPairs
GO

CREATE PROCEDURE dbo.spFX_GetEventCurrencyPairs
	@eventid as int
AS
	SELECT ecp.eventid, evt.name, cp.base, cp.quote, cp.boughtsold_level, cp.inactive
	from fxevent_currencypairs ecp
	left join fxevents evt
		on ecp.eventid = evt.id
	left join currencypairs cp
		on ecp.cp_id = cp.id
	where ecp.eventid = @eventid
GO

grant execute on dbo.spFX_GetEventCurrencyPairs to TRADEJOURNAL_GRP
