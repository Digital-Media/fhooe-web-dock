#!/bin/bash
echo "Stop running containers"
docker compose stop

echo "This Containers will be deleted with its volumes and images"
docker ps -f "status=exited"
read -p "Continue? [Y/n]" -r answer;

if [ $answer != "Y" ]
then
   echo "Containers, images and volumes are not removed"
   docker compose start
   read -p "Press any key to resume ..."
   exit 1
else
  echo "Remove containers"
  docker compose stop --volumes

  echo "Remove all unused images, containers, networks and volumes"
  docker system prune --volumes --all --force

  echo "Update fhooe-web-dock from GitHub"
  git pull

  echo """Create and start the containers again in the background (detached)"
  docker compose up --detach

  echo "All finished. Enjoy your updated version of fhooe-web-dock!"
  read -p "Press any key to resume ..."
fi

