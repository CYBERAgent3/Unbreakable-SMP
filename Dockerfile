FROM eclipse-temurin:17-jre

WORKDIR /app

COPY proxy.jar /app/proxy.jar
COPY config.yml /app/config.yml

EXPOSE 8080

CMD ["java", "-Xms512M", "-Xmx512M", "-jar", "proxy.jar"]
