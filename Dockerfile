FROM eclipse-temurin:17-jre

WORKDIR /app

# Velocity proxy
COPY Velocity.jar /app/velocity.jar
COPY velocity.toml /app/velocity.toml

# Eagler plugin (folder must exist in repo)
COPY plugins /app/plugins

EXPOSE 8080

CMD ["java", "-Xms512M", "-Xmx512M", "-jar", "velocity.jar"]
