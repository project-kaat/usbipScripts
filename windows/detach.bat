cd C:\usbip

call usbipImportConfig.bat

if %ENABLE_SSH_ON_DETACH%==1 ssh %SSH_SERVER% %REMOTE_SCRIPT_PATH%/usbipExport.sh unbind
