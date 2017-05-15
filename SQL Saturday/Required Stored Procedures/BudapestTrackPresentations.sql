ALTER PROC BudapestTrackPresentations
		--ENTER A TRACK
		--IF NO TRACK ENTERED DEFAULT VALUE OF 4 IS USED
		-- Budapest only has track #'s 1,2,3,4,5,6
		@track INT = 4
	AS
	--If invalid data raise error
	BEGIN TRY
		--display track, title, city
		SELECT Schedule.track_id,Presentation.title, Event_Locations.event_city
		FROM Schedule
		INNER JOIN Presentation ON Schedule.presentation_id = Presentation.presentation_id
		INNER JOIN Event_Locations ON Presentation.event_location_id = Event_Locations.event_location_id
		WHERE Schedule.track_id = @track
		AND Event_Locations.event_city = 'Budapest'
	END TRY
	BEGIN CATCH
		DECLARE @ErrorMessage NVARCHAR(4000);
  	DECLARE @ErrorSeverity INT;
  	DECLARE @ErrorState INT;
  	SELECT
    	@ErrorMessage = ERROR_MESSAGE(),
    	@ErrorSeverity = ERROR_SEVERITY(),
    	@ErrorState = ERROR_STATE();
  		RAISERROR (@ErrorMessage, @ErrorSeverity, @ErrorState);
	END CATCH
GO
