@echo off

set superior_dir=%1
echo "get config"
for /f  "eol=; tokens=2,2 delims==" %%i in ('findstr /i "^cn_internal_port"
%superior_dir%\conf\iotdb-confignode.properties') do (
set cn_internal_port=%%i
)
for /f  "eol=; tokens=2,2 delims==" %%i in ('findstr /i "cn_internal_address"
%superior_dir%\conf\iotdb-confignode.properties') do (
set cn_internal_address=%%i
)
echo "start loop"
for /f "tokens=5" %%a in ('netstat /ano ^| findstr %cn_internal_address%:%cn_internal_port%') do (
echo %cn_internal_address%:%cn_internal_port%, pid=%%a
echo "start confignode succeed. continue."
exit /B
)
echo "over loop"
echo "start confignode failed."
exit 1
