/* =============================================
 * spFX_AddEventAssociation
 * File: spFX_AddEventAssociation.sql
 * 
 * Desc: Add new event association (indicator)
 * =============================================
 */

-- Drop stored procedure if it already exists
IF EXISTS (
  SELECT * 
    FROM INFORMATION_SCHEMA.ROUTINES 
   WHERE SPECIFIC_SCHEMA = N'dbo'
     AND SPECIFIC_NAME = N'spFX_AddEventAssociation' 
)
   DROP PROCEDURE dbo.spFX_AddEventAssociation
GO

CREATE PROCEDURE dbo.spFX_AddEventAssociation
	@eventid as nvarchar(10), @ind_id as nvarchar(10), @ind_order as int, @ind_importance as smallint
		, @ind_positive_threshhold as numeric(19,5), @ind_positive_threshhold_weight as smallint
		, @ind_negative_threshhold as numeric(19,5), @ind_negative_threshhold_weight as smallint
		, @err_no as int output, @err_desc as nvarchar(255) output
AS
	
	-- Is event id valid?
	if (select count(id) from fxevents where eventid = @eventid) = 0
	begin
		select @err_no = 1003
		select @err_desc = err_desc + ' (' + CAST(@eventid as varchar(10)) + ')' from fxerrors where err_no = @err_no
	end
	-- Is indicator id valid?
	if (select count(id) from fxevents where eventid = @ind_id) = 0
	begin
		select @err_no = 1101
		select @err_desc = err_desc + ' (' + CAST(@ind_id as varchar(10)) + ')' from fxerrors where err_no = @err_no
	end
	-- Does event association already exist?
	if (select count(id) from fxevent_associations where eventid = @eventid and ind_id = @ind_id) > 0
	begin
		select @err_no = 1101
		select @err_desc = err_desc from fxerrors where err_no = @err_no
	end
	-- Add event association.
	else
	begin
		insert into fxevent_associations (eventid, ind_id, ind_order, ind_importance, ind_positive_threshhold,
			ind_positive_threshhold_weight, ind_negative_threshhold, ind_negative_threshhold_weight)
		values (@eventid, @ind_id, @ind_order, @ind_importance,  @ind_positive_threshhold
			, @ind_positive_threshhold_weight, @ind_negative_threshhold, @ind_negative_threshhold_weight)

	
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

grant execute on dbo.spFX_AddEventAssociation to TRADEJOURNAL_GRP
