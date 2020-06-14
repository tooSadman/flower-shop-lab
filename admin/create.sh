docker network create flowershop
docker run --name flowershop_db -e POSTGRES_PASSWORD=mysecretpassword -d postgres
docker exec -ti flowershop_db hostname -i
echo "Press Enter to continue"; read
docker cp ../migrations/20200529014155_create_db.up.sql flowershop_db:/ 
docker cp pgsql.sql flowershop_db:/
docker exec -ti flowershop_db bash -c "PGPASSWORD=mysecretpassword psql -U postgres -f pgsql.sql && PGPASSWORD=mysecretpassword psql -d flowershop -U postgres -f pg.sql"
docker build -t flowershop_admin -f Dockerfile_admin .
docker run --net flowershop --name flowershop_admin -dti -p 3000:3000 flowershop_admin