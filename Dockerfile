FROM java:8-jdk

MAINTAINER Bulktrade GmbH (info@bulktrade.org)

RUN apt-get update && apt-get upgrade -y && apt-get install -y git maven

WORKDIR /
RUN mkdir -p /app

RUN git clone https://github.com/OrienteerDW/wicket-orientdb.git /wicket-orientdb
WORKDIR /wicket-orientdb
RUN mvn clean install

RUN git clone https://github.com/OrienteerDW/Orienteer.git /orienteer
WORKDIR /orienteer
RUN mvn clean install

WORKDIR /app
RUN cp /orienteer/orienteer-standalone/target/orienteer-standalone.jar /app/
RUN rm -r /wicket-orientdb /orienteer

RUN rm -rf /var/lib/apt/lists/*

EXPOSE 8080
VOLUME ["/app/./databases"]

ADD ./orienteer.properties /app/orienteer.properties
ADD ./start.sh /app/start.sh

CMD ["/app/start.sh"]
