
Hello professor,

I seeded all my tables with custom data.
My stored proceedures are all uploaded to Git and the Database.

Here are were to find all of your requirements:
------------------------------------------------
1) Create insert procedure that inserts presentation(s) and it's speakers.
- this stored procedure is called: 'insertPresentations' on the DB and 'insertPresentations.sql' on Git
- Example of how to use: EXECUTE insertPresentations 'Paul Rizza', 'Super SQL'
###UPDATE####
Fixed issue where you could not insert more than one person per presentation. You can now insert as many people per presentation you wish.

2) I will test selecting presentations and speakers associated with them.
- This stored procedure is called: 'selectSpeakerPresentations' on the DB and 'selectSpeakerPresentations.sql' on Git
- Example of how to use: EXECUTE selectSpeakerPresentations 'Paul Rizza'

3) Create select procedure that selects presentations per track in the Budapest.
- This stored procedure is called: 'BudapestTrackPresentations' on the DB and 'BudapestTrackPresentations.sql'  on Git
- Example of how to use: EXECUTE BudapestTrackPresentations 1
- There are only 6 tracks so only use tracks 1-6

4) Create databse backup script - the simplest form
- I attempted to do the simplest form but it would not let me on the server. So I did the following:
- Created a full backup on the DB called 'dbBackup' and 'dbBackup.sql' on Git
- I created another seperate rebuild tables stored procedure called 'rebuildTables' on the DB and 'rebuildTables.sql' on Git


Please let me know if you have any questions. I did add comments in each of the stored procedures to help you use them. 
Thank you for a great semester. Hope you enjoy the break.


Regards,

Dino Biel
S17Guest24
