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
            - CERT_NAME=default
            - VIRTUAL_PORT=8080
    
[On DockerHub](https://registry.hub.docker.com/u/bulktrade/orienteer/)
[On GitHub](https://https://github.com/deacix/docker-orienteer)
