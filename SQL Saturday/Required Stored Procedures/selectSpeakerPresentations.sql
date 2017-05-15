--This Procedure selects a speaker and returns their presentations
--enter the name in this format: selectSpeakerPresentations 'Paul Rizza'
ALTER PROC selectSpeakerPresentations
  @speaker NVARCHAR(80)
  AS
  BEGIN TRY
    SELECT People.first_name, People.last_name, Presentation.title
    FROM Presentation
    INNER JOIN People ON Presentation.people_id = People.people_id
    WHERE first_name = SUBSTRING(@speaker, 1, CHARINDEX(' ', @speaker) - 1) AND
          last_name = REVERSE(SUBSTRING(REVERSE(@speaker), 1, CHARINDEX(' ', REVERSE(@speaker)) - 1))
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
