docker compose down
docker image prune -a
docker volume rm --force fhooe-web-dock_dbdata;
docker compose up -d