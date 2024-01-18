@echo off

echo Stopping all running fhooe-web-dock containers
docker compose stop

echo These containers will be deleted together with their volumes and images and afterwards recreated:
docker ps -f "status=exited"

:prompt
set /p "answer=Continue? [Y/n] "
if "%answer%"=="" set answer=Y

if /i "%answer%"=="Y" goto proceed
if /i "%answer%"=="y" goto proceed
if /i "%answer%"=="N" goto cancel
if /i "%answer%"=="n" goto cancel

echo Please answer Y or n to continue.
goto prompt

:proceed
echo Stop all running containers
docker compose down --volumes

echo Remove all unused images, containers, networks and volumes
docker system prune --volumes --all --force

echo Update fhooe-web-dock from GitHub
git pull

echo Create and start the containers again in the background (detached)
docker compose up --detach

echo All finished. Enjoy your updated version of fhooe-web-dock!
pause
exit

:cancel
echo Containers, images and volumes are not removed. Keeping the current versions and restarting...
docker compose start
pause
exit
