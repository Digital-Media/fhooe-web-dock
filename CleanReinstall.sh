#!/bin/bash
echo "Stopping all running fhooe-web-dock containers"
docker compose stop

echo "These containers will be deleted together with their volumes and images and afterwards recreated:"
docker compose ps -a

while true; do
    read -p "Continue? [Y/n] " -r answer
    answer=${answer:-Y}  # Set default value to Y if no input is provided

    case $answer in
        [Yy]* ) 
            break;;  # Proceed if the answer is Y or y
        [Nn]* ) 
            echo "Containers, images and volumes are not removed. Keeping the current versions and restarting..."
            docker compose start
            read -p "Press any key to exit ..."
            exit 1;;
        * ) 
            echo "Please answer Y or n to continue.";;  # Ask again for any other input
    esac
done

echo "Remove containers, images, and volumes associated with this compose file"
docker compose down --rmi all --volumes --remove-orphans

echo "Remove any dangling images related to this project"
docker image prune --force --filter "label=com.docker.compose.project=%COMPOSE_PROJECT_NAME%"

echo "Update fhooe-web-dock from GitHub"
git pull

echo "Build the images from scratch"
docker compose build --no-cache

echo "Create and start the containers in the background (detached)"
docker compose up --detach

echo "All finished. Enjoy your updated version of fhooe-web-dock!"
read -p "Press any key to exit ..."
