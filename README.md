# docker-orienteer
Orienteer System dockerized!

### Installation

Pull image:

	docker pull bulktrade/orienteer

Run with docker:

	docker run -dti bulktrade/orienteer
	
Run with docker-compose:

	docker-compose up -d
	
### Usage with docker-compose

	orienteer:
        image: bulktrade/orienteer
        restart: always
        ports:
            - 8080
        environment:
            - VIRTUAL_HOST=~^orienteer\..* # for rproxy (jwilder/nginx-proxy)
            - CERT_NAME=default # for rproxy (jwilder/nginx-proxy)
            - VIRTUAL_PORT=8080 # for rproxy (jwilder/nginx-proxy)
            - ORIENTEER_PRODUCTION=true # Set Orienteer to production mode
            #- ORIENTDB_HOST=localhost
            #- ORIENTDB_DB=Orienteer
            #- ORIENTDB_DB_USER=reader
            #- ORIENTDB_DB_USER_PASSWORD=reader
            #- ORIENTDB_ROOT_USER=admin
            #- ORIENTDB_ROOT_USER_PASSWORD=admin
        #volumes:
        #    - ./orienteer.properties:/app/orienteer.properties # Set your own config file
    
### Links
[On DockerHub](https://registry.hub.docker.com/u/bulktrade/orienteer/)

[On GitHub](https://https://github.com/deacix/docker-orienteer)

[Orienteer On GitHub](https://github.com/OrienteerDW/Orienteer)
