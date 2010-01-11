/* =============================================
 * spFX_GetEventTransactions
 * File: spFX_GetEventTransactions.sql
 * 
 * Desc: Returns event transactions
 * =============================================
 */

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spFX_GetEventTransactions' 
)
   DROP PROCEDURE dbo.spFX_GetEventTransactions
GO

CREATE PROCEDURE dbo.spFX_GetEventTransactions
	@eventid as int
AS
	SELECT etrx.eventid, etrx.name, etrx.eventdate, etrx.eventtime, etrx.previous
		, etrx.forecast, etrx.actual, etrx.currency
	from fxevent_transactions etrx
	left join fxevents evt
		on etrx.eventid = evt.eventid
	where etrx.eventid = @eventid
	order by etrx.eventdate, etrx.eventtime
GO

grant execute on dbo.spFX_GetEventTransactions to TRADEJOURNAL_GRP
