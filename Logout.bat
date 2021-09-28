@ECHO OFF
CLS
TITLE "Running logout scripts"
CD C:\AmAr\Apps\Scripts
FOR /f "tokens=2 delims==" %%a IN ('wmic OS Get localdatetime /value') DO SET "dt=%%a"
SET Trigger=%1
SET "YY=%dt:~2,2%" & set "YYYY=%dt:~0,4%" & set "MM=%dt:~4,2%" & set "DD=%dt:~6,2%"
SET "HH=%dt:~8,2%" & set "Min=%dt:~10,2%" & set "Sec=%dt:~12,2%"
SET "datestamp=%YYYY%%MM%%DD%" & set "timestamp=%HH%%Min%%Sec%"
SET "fullstamp=%YYYY%-%MM%-%DD%_%HH%-%Min%-%Sec%"
:BEGIN
ECHO %date:~-4%%date:~4,2%%date:~7,2%_%time:~0,2%%time:~3,2%%time:~6,2%---------Started by %Trigger%>>"C:\AmAr\Apps\Scripts\LogOut.log"
CHOICE /N /C:12 /T 5 /D 1 /M "Press (1,2) 1 to continue or 2 to cancel: "
IF ERRORLEVEL ==2 GOTO END
IF ERRORLEVEL ==1 GOTO KILLING
GOTO END
:KILLING
echo %date:~-4%%date:~4,2%%date:~7,2%_%time:~0,2%%time:~3,2%%time:~6,2%--------->>"C:\AmAr\Apps\Scripts\LogOut.log"
echo 1: Skype for business >>"C:\AmAr\Apps\Scripts\LogOut.log"
taskkill.exe /IM lync.exe /T /F >>"C:\AmAr\Apps\Scripts\LogOut.log"
echo %date:~-4%%date:~4,2%%date:~7,2%_%time:~0,2%%time:~3,2%%time:~6,2%--------->>"C:\AmAr\Apps\Scripts\LogOut.log"
echo 2: Microsoft Teams >>"C:\AmAr\Apps\Scripts\LogOut.log"
taskkill.exe /IM Teams.exe /T /F >>"C:\AmAr\Apps\Scripts\LogOut.log"

:END
REM 
echo 3: Backing up files >>"C:\AmAr\Apps\Scripts\LogOut.log"
xcopy C:\AmAr \\nav01001fpds01-201s\q_hme_09$\nannaam\data\AmAr /E /G /H /Y /D:%MM%-%DD%-%YY% /EXCLUDE:C:\AmAr\Apps\Scripts\list-of-files-exclude.txt>>"C:\AmAr\Apps\Scripts\LogOut.log"

echo %date:~-4%%date:~4,2%%date:~7,2%_%time:~0,2%%time:~3,2%%time:~6,2%---------Ended>>"C:\AmAr\Apps\Scripts\LogOut.log"
mv C:\AmAr\Apps\Scripts\LogOut.log C:\AmAr\Apps\Scripts\log\LogOut__%YYYY%%MM%%DD%.log
exit