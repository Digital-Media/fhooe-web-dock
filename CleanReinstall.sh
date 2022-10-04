docker compose down -v
docker image prune -a
docker volume prune -f;
docker compose up -d
