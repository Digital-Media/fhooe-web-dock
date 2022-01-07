# fhooe-webdocker

- cd <path-to>/Dockerfile
- docker build --tag my_webdock .
- docker build -t my_webdock .
- docker build -t my_webdock -f <path-to>/Dockerfile
If you use Docker-Desktop you are done in the command-line and can start a container with Docker-Desktop.
Otherwise, use docker commands.

- docker image ls
- docker image history webdock:latest 
- docker image remove webdock

- docker container run -dit --name my_webdock -p 80:80 -p 443:443 my_webdock /bin/bash
- docker container run -dit --rm --name my_webdock -p 80:80 -p 443:443 my_webdock /bin/bash
- docker container run -dit --rm --name my_webdock -p 80:80 -p 443:443 my_webdock "/usr/sbin/apache2ctl start"
- docker exec -it my_webdock /bin/bash
- docker exec -it my_webdock netstat -apnt
- docker exec -it my_webdock /usr/sbin/apache2ctl start
- docker container stop my_webdock
- docker rm --force my_webdock