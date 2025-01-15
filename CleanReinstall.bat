@echo off

echo Stopping all running fhooe-web-dock containers
docker compose stop

echo These containers will be deleted together with their volumes and images and afterwards recreated:
docker compose ps -a

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
echo Remove containers, images, and volumes associated with this compose file
docker compose down --rmi all --volumes --remove-orphans

echo Remove any dangling images related to this project
docker image prune --force --filter "label=com.docker.compose.project=%COMPOSE_PROJECT_NAME%"

echo Update fhooe-web-dock from GitHub
git pull

echo Build the images from scratch
docker compose build --no-cache

echo Create and start the containers in the background (detached)
docker compose up --detach

echo All finished. Enjoy your updated version of fhooe-web-dock!
pause
exit

:cancel
echo Containers, images and volumes are not removed. Keeping the current versions and restarting...
docker compose start
pause
exit
