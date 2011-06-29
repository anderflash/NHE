del /S /Q "%1\*"
rd /S /Q "%1\WEB-INF"
md "%1\WEB-INF"
xcopy /Y /E "%~dp0..\WEB-INF" "%1\WEB-INF"