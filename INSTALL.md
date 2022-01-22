# Install LAMPP  Environment with Docker

## Install Docker

- [Download Docker Desktop for Windows or MAC](https://www.docker.com/products/docker-desktop)
- [Install Docker for Windows](https://docs.docker.com/desktop/windows/install/)
- [Install Docker for MAC](https://docs.docker.com/desktop/mac/install/)
- [Install Docker for Linux](https://docs.docker.com/engine/install/)

## Install fhooe-web-dock and start Containers
Open Powershell (PS) or other Terminal (prompt my be different then).

`PS ???> ` 
```shell
cd <path-where-your-Docker-should-reside>
```
`PS path-where-your-Docker-should-reside> `
```shell
mkdir Docker # if not already exists
```
```shell
cd Docker
```
`PS path-to-Docker> `
```shell
git clone fhooe-web-dock
cd fhooe-web-dock
```
`PS path-to-Docker/Docker/fhooe-web-dock> `
```shell
mkdir webapp
```
no promt from now on
```shell
docker compose up -d
```
` [+] Running 5/5 `\
`    - Network webnet                  Created                                                                   0.0s `\
`    - Volume "fhooe-web-dock_dbdata"  Created                                                                   0.0s `\
`    - Container webapp                Started                                                                   5.3s `\
`    - Container mariadb               Started                                                                   5.0s `\
`   - Container pma                   Started                                                                   3.2s`
## Stopping the Containers
```shell
docker compose stop
```
` - Container pma      Stopped                                                                                   4.2s `\
` - Container webapp   Stopped                                                                                  4.1s `\
` - Container mariadb  Stopped `
## Starting the Containers without rebuilding
```shell
docker compose start
```
## Stopping the Containers and removing them
```shell
docker compose down
```
## See which images exist
```shell
docker image ls
```
### besides others there should be the following entries
```shell
REPOSITORY                       TAG         IMAGE ID       CREATED        SIZE
fhooe-web-dock_db             latest      96a53a828586   2 days ago     565MB
fhooe-web-dock_php-apache     latest      5605e6a73edc   2 days ago     561MB
phpmyadmin/phpmyadmin         latest      2e5141bbcbfb   7 months ago   474MB
```
## Delete images
```shell
docker image rm fhooe-web-dock_php-apache
docker image rm fhooe-web-dock_db
docker image rm phpmyadmin/phpmyadmin
```
## List Containers
```
docker container ls
```
## List Volumes
```
docker volume ls
```
## Debugging:
```shell
docker exec -it webapp /bin/bash
docker exec -it mariadb /bin/bash
docker exec -it pma /bin/bash
```
## See processes running in Container webshop
`PS path-to-Docker/Docker/fhooe-web-dock> ` 
```shell
docker exec -it webapp /bin/bash
```
`root@<image-id>:/var/www/html# `
```shell
ps -aux
```
```shell
 USER       PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
 root         1  0.0  0.2  78988 26568 ?        Ss   08:30   0:00 apache2 -DFOREGROUND
 www-data    17  0.0  0.0  79256 11952 ?        S    08:30   0:00 apache2 -DFOREGROUND
 www-data    18  0.0  0.0  79256 11952 ?        S    08:30   0:00 apache2 -DFOREGROUND
 www-data    19  0.0  0.0  79256 11952 ?        S    08:30   0:00 apache2 -DFOREGROUND
 www-data    20  0.0  0.0  79256 11952 ?        S    08:30   0:00 apache2 -DFOREGROUND
 www-data    21  0.0  0.0  79256 11952 ?        S    08:30   0:00 apache2 -DFOREGROUND
 root        22  0.1  0.0   4092  3336 pts/0    Ss   08:40   0:00 /bin/bash
 root        29  0.0  0.0   6928  2908 pts/0    R+   08:40   0:00 ps -aux
```
`root@<image-id>:/var/www/html# ps -ef `
```shell
 UID        PID  PPID  C STIME TTY          TIME CMD
 root         1     0  0 08:30 ?        00:00:00 apache2 -DFOREGROUND
 www-data    17     1  0 08:30 ?        00:00:00 apache2 -DFOREGROUND
 www-data    18     1  0 08:30 ?        00:00:00 apache2 -DFOREGROUND
 www-data    19     1  0 08:30 ?        00:00:00 apache2 -DFOREGROUND
 www-data    20     1  0 08:30 ?        00:00:00 apache2 -DFOREGROUND
 www-data    21     1  0 08:30 ?        00:00:00 apache2 -DFOREGROUND
 root        22     0  0 08:40 pts/0    00:00:00 /bin/bash
 root        30    22  0 08:40 pts/0    00:00:00 ps -ef
```
`PS path-to-Docker/Docker/fhooe-web-dock> `
```shell
docker exec -it webapp /bin/bash -c "ps -aux"
```
## Maintaining a database in Container mariadb
`PS path-to-Docker/Docker/fhooe-web-dock> `
```shell
docker exec -it mariadb /bin/bash -c "mariadb -uonlineshop -pgeheim"
```
```shell
 Welcome to the MariaDB monitor.  Commands end with ; or \g.
 Your MariaDB connection id is 7
 Server version: 10.7.1-MariaDB-1:10.7.1+maria~focal mariadb.org binary distribution

 Copyright (c) 2000, 2018, Oracle, MariaDB Corporation Ab and others.

 Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

 MariaDB [(none)]> drop database onlineshop;
 Query OK, 11 rows affected (0.229 sec)

 MariaDB [(none)]> 
 ```
```shell
 show databases;
```
```shell
 +--------------------+
 | Database           |
 +--------------------+
 | information_schema |
 +--------------------+
 1 row in set (0.001 sec)

 MariaDB [(none)]> 
 ```
```shell
 exit
```
`PS path-to-Docker/Docker/fhooe-web-dock> `
## Starting a database script from Powershell
`PS path-to-Docker/Docker/fhooe-web-dock> `
```shell
docker exec -it mariadb /bin/bash -c "mariadb -uonlineshop -pgeheim </tmp/bin/onlineshop.sql"
```

# Toubleshooting chrome + hsts
- [Follow Link for Instructions](https://superuser.com/questions/1400200/chrome-persistently-redirecting-to-https-for-http-site)
- enter `chrome://net-internals/#hsts` in Chrome Browser
- goto end of site. 
- enter "localhost" and press "Delete"
```
# Delete domain security policies
Input a domain name to delete its dynamic domain security policies (HSTS and Expect-CT).(You cannot delete preloaded entries.):
Domain:[example.com -> localhost][Delete]
```
