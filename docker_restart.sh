#!/bin/sh
sudo docker-compose down;
grep 'FOOECHO' Dockerfile && (sed -i -e 's/FOOECHO/BARECHO/g' Dockerfile && echo "A") || (sed -i -e 's/BARECHO/FOOECHO/g' Dockerfile && echo "B")
sudo docker-compose up --build -d;
sudo docker-compose logs -f;