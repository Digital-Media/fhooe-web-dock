#!/bin/bash
echo "Stopping all running fhooe-web-dock containers"
docker compose stop

echo "These containers will be deleted together with their volumes and images"
docker ps -f "status=exited"

while true; do
    read -p "Continue? [Y/n] " -r answer
    answer=${answer:-Y}  # Set default value to Y if no input is provided

    case $answer in
        [Yy]* ) 
            break;;  # Proceed if the answer is Y or y
        [Nn]* ) 
            echo "Containers, images and volumes are not removed. Restarting..."
            docker compose start
            read -p "Press any key to exit ..."
            exit 1;;
        * ) 
            echo "Please answer Y or n.";;  # Ask again for any other input
    esac
done

echo "Stop all running containers"
docker compose down --volumes

echo "Remove all unused images, containers, networks and volumes"
docker system prune --volumes --all --force

echo "Update fhooe-web-dock from GitHub"
git pull

echo "Create and start the containers again in the background (detached)"
docker compose up --detach

echo "All finished. Enjoy your updated version of fhooe-web-dock!"
read -p "Press any key to exit ..."


