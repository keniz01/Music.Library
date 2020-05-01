/****** Object:  User [NT AUTHORITY\SYSTEM]    Script Date: 20/03/2020 21:36:18 ******/
--CREATE USER [NT AUTHORITY\SYSTEM] FOR LOGIN [NT AUTHORITY\SYSTEM] WITH DEFAULT_SCHEMA=[dbo]
--GO
--ALTER ROLE [db_owner] ADD MEMBER [NT AUTHORITY\SYSTEM]
--GO
/****** Object:  Login [IIS APPPOOL\DefaultAppPool]    Script Date: 22/04/2020 12:07:54 ******/
--IF NOT EXISTS (SELECT 1 FROM [sys].[database_principals] 
--		WHERE [type] = N'U' AND [name] = N'IIS APPPOOL\DefaultAppPool')
--BEGIN
--	EXEC sp_adduser [IIS APPPOOL\DefaultAppPool]
--END
--ELSE
--BEGIN
--	CREATE LOGIN [IIS APPPOOL\DefaultAppPool] FROM WINDOWS WITH DEFAULT_DATABASE=[master], DEFAULT_LANGUAGE=[us_english]
--END
--GO