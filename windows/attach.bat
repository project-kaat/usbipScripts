cd C:\usbip

call usbipImportConfig.bat

echo %ENABLE_SSH_ON_ATTACH%

if %ENABLE_SSH_ON_ATTACH%==1 ssh %SSH_SERVER% %REMOTE_SCRIPT_PATH%/usbipExport.sh bind

echo %IMPORT_BUSIDS%

for %%i in (%IMPORT_BUSIDS%) do usbip.exe attach -r %USBIP_SERVER% -b %%i
