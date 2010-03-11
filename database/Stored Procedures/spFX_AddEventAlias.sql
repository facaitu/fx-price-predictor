/* =============================================
 * spFX_AddEventAlias
 * File: spFX_AddEventAlias.sql
 * 
 * Desc: Add new event alias
 * =============================================
 */

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spFX_AddEventAlias' 
)
   DROP PROCEDURE dbo.spFX_AddEventAlias
GO

CREATE PROCEDURE dbo.spFX_AddEventAlias
	@eventid as nvarchar(10), @aliasname as nvarchar(50)
	, @err_no as int output, @err_desc as nvarchar(255) output
AS
	
	-- Is event id valid?
	if (select count(id) from fxevents where eventid = @eventid) = 0
	begin
		select @err_no = 1003
		select @err_desc = err_desc + ' (' + CAST(@eventid as varchar(10)) + ')' from fxerrors where err_no = @err_no
	end
	-- Does event alias already exist?
	if (select count(id) from fxevent_aliases where eventid = @eventid and name = @aliasname) > 0
	begin
		select @err_no = 1301
		select @err_desc = err_desc from fxerrors where err_no = @err_no
	end
	-- Add event association.
	else
	begin
		insert into fxevent_aliases (eventid, name)
		values (@eventid, @aliasname)

	
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

grant execute on dbo.spFX_AddEventAlias to TRADEJOURNAL_GRP
