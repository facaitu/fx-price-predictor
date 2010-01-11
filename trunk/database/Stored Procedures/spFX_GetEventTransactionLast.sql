/* =============================================
 * spFX_GetEventTransactionLast
 * File: spFX_GetEventTransactionLast.sql
 * 
 * Desc: Returns the last (most recent) event transaction.
 * =============================================
 */

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spFX_GetEventTransactionLast' 
)
   DROP PROCEDURE dbo.spFX_GetEventTransactionLast
GO

CREATE PROCEDURE dbo.spFX_GetEventTransactionLast
	@eventid as int
AS
	SELECT top 1 etrx.eventid, etrx.name, etrx.eventdate, etrx.eventtime, etrx.previous
		, etrx.forecast, etrx.actual, etrx.currency
	from fxevent_transactions etrx
	left join fxevents evt
		on etrx.eventid = evt.eventid
	where etrx.eventid = @eventid
	order by etrx.eventdate, etrx.eventtime desc
GO

grant execute on dbo.spFX_GetEventTransactionLast to TRADEJOURNAL_GRP
