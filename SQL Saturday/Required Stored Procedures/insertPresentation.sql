-- Enter a presenter 'First last' and presentation 'This is How to SQL'
-- DO NOT SPLIT 'First Last' into 'First' 'Last' I do that for you.
-- Example: insertPresentation 'Paul Rizza', 'Showing off in SQL'
ALTER PROCEDURE [dbo].[insertPresentation]
  @speaker NVARCHAR(80),
  @presentation VARCHAR(100)


AS
BEGIN
  BEGIN TRY
  --if first name and last name are not in people table
  IF NOT EXISTS(SELECT first_name, last_name
                FROM People
                WHERE first_name = SUBSTRING(@speaker, 1, CHARINDEX(' ', @speaker) - 1) AND
                      last_name = REVERSE(SUBSTRING(REVERSE(@speaker), 1, CHARINDEX(' ', REVERSE(@speaker)) - 1)))
                BEGIN
                    INSERT INTO People SELECT
                       SUBSTRING(@speaker, 1, CHARINDEX(' ', @speaker) - 1)                            AS first_name,
                       REVERSE(SUBSTRING(REVERSE(@speaker), 1, CHARINDEX(' ', REVERSE(@speaker)) - 1)) AS last_name

                    INSERT INTO Presentation (title, people_id) VALUES (@presentation, (SELECT people_id
                                                                FROM People
                                                                WHERE first_name = SUBSTRING(@speaker, 1,CHARINDEX(' ',@speaker) -1)
                                                                AND last_name = REVERSE(SUBSTRING(REVERSE(@speaker), 1,CHARINDEX(' ', REVERSE(@speaker)) -1))))

                END

  -- if @presentation is not in the title of presentation
      IF NOT EXISTS(SELECT title
                    FROM Presentation
                    WHERE title = @presentation)
        BEGIN
        INSERT INTO Presentation (title, people_id) VALUES (@presentation, (SELECT people_id
                                                    FROM People
                                                    WHERE first_name = SUBSTRING(@speaker, 1,CHARINDEX(' ',@speaker) -1)
                                                    AND last_name = REVERSE(SUBSTRING(REVERSE(@speaker), 1,CHARINDEX(' ', REVERSE(@speaker)) -1))))

        END
    --This checks to see if the presentation and the person are the same.
    --If they are not the same, this means its a presentation with more than 1 presenter.
    --This will add the second presenter to the presentation.
        IF NOT EXISTS(SELECT title
                  FROM Presentation
                  INNER JOIN People ON Presentation.people_id = People.people_id
                  WHERE title = @presentation
                  AND first_name =SUBSTRING(@speaker, 1,CHARINDEX(' ',@speaker) -1)
                  AND last_name =  REVERSE(SUBSTRING(REVERSE(@speaker), 1,CHARINDEX(' ', REVERSE(@speaker)) -1)))
        BEGIN
         INSERT INTO Presentation (title, people_id) VALUES (@presentation, (SELECT people_id
                                                    FROM People
                                                    WHERE first_name = SUBSTRING(@speaker, 1,CHARINDEX(' ',@speaker) -1)
                                                    AND last_name = REVERSE(SUBSTRING(REVERSE(@speaker), 1,CHARINDEX(' ', REVERSE(@speaker)) -1))))


        END

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
END
GO
