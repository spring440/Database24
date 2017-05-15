CREATE PROC dbBackup
--The Database would not let me create a simple backup
-- I used the full backup instead, but also created my own rebuild table
--See 'rebuildTables.sql' if need to rebuild tables
AS 
BEGIN
	BACKUP DATABASE [s17guest24] TO  DISK = N'C:\Program Files\Microsoft SQL Server\MSSQL11.CSDB440\MSSQL\Backup\s17guest24.bak' WITH NOFORMAT, NOINIT,  NAME = N's17guest24-Full Database Backup', SKIP, NOREWIND, NOUNLOAD,  STATS = 10
END
GO
