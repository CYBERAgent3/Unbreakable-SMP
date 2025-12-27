FROM eclipse-temurin:17-jre

WORKDIR /app

# Install curl to download velocity
RUN apt-get update && apt-get install -y curl && rm -rf /var/lib/apt/lists/*

# Download latest Velocity (stable) at build time
RUN curl -L -o velocity.jar https://api.papermc.io/v2/projects/velocity/versions/3.4.0/builds/487/downloads/velocity-3.4.0-487.jar

COPY velocity.toml /app/velocity.toml
COPY plugins /app/plugins

EXPOSE 8080

CMD ["java", "-Xms512M", "-Xmx512M", "-jar", "velocity.jar"]
