# docker-orienteer
Orienteer System dockerized!

### Installation

Pull image:

	docker pull bulktrade/orienteer
	
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
        #volumes:
        #    - ./orienteer.properties:/app/orienteer.properties # Set your own config file
    
[On DockerHub](https://registry.hub.docker.com/u/bulktrade/orienteer/)
[On GitHub](https://https://github.com/deacix/docker-orienteer)