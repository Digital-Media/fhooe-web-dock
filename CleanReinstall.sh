docker compose down
docker image prune
docker volume rm --force fhooe-web-dock_dbdata;
docker compose up -d