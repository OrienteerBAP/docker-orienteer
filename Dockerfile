FROM java:8
RUN apt-get update && apt-get upgrade -y && apt-get install -y wget

WORKDIR /
RUN mkdir -p /app

RUN wget "https://github.com/OrienteerDW/Orienteer/releases/download/v1.1/orienteer-standalone.jar" -O orienteer-standalone.jar &&\
    mv orienteer-standalone.jar /app/orienteer-standalone.jar

RUN rm -rf /var/lib/apt/lists/*

EXPOSE 8080
VOLUME ["/app/./databases"]

WORKDIR /app
ADD ./orienteer.properties /app/orienteer.properties

CMD ["java -Xmx512m -Xms512m -jar orienteer-standalone.jar --embedded --config=/app/orienteer.properties"]
