/* =============================================
 * spFX_DelEventStaging
 * File: spFX_DelEventStaging.sql
 * 
 * Desc: Delete new event
 * =============================================
 */

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spFX_DelEventStaging' 
)
   DROP PROCEDURE dbo.spFX_DelEventStaging
GO

CREATE PROCEDURE dbo.spFX_DelEventStaging
	@eventid as nvarchar(10), @err_no as int output, @err_desc as nvarchar(255) output
AS
	
	-- Is event id valid?
	if (select count(eventid) from fxevents_staging where eventid = @eventid) = 0
	begin
		select @err_no = 1003
		select @err_desc = err_desc from fxerrors where err_no = @err_no
	end
	-- Begin event deletes.
	else
	begin
		-- Delete event.
		delete from fxevents_staging where eventid = @eventid
		
		if @@ERROR > 0
		begin
			select @err_no = @@ERROR
		end
	end
	
if @err_no > 0 
	return 1
else
	return 0
	
GO

grant execute on dbo.spFX_DelEventStaging to TRADEJOURNAL_GRP
