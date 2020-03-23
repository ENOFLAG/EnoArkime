#!/bin/sh
docker-compose down;
grep 'FOOECHO' Dockerfile && (sed -i -e 's/FOOECHO/BARECHO/g' Dockerfile && echo "A") || (sed -i -e 's/BARECHO/FOOECHO/g' Dockerfile && echo "B")
docker-compose up --build -d;
docker-compose logs -f;