FROM eclipse-temurin:17-jre

WORKDIR /app

RUN apt-get update \
  && apt-get install -y curl unzip \
  && rm -rf /var/lib/apt/lists/*

# Download Velocity automatically (prevents corrupt jars)
RUN curl -fL --retry 5 --retry-delay 2 \
  -o /app/velocity.jar \
  "https://api.papermc.io/v2/projects/velocity/versions/3.3.0/builds/389/downloads/velocity-3.3.0-389.jar" \
  && unzip -t /app/velocity.jar > /dev/null

COPY velocity.toml /app/velocity.toml
COPY plugins /app/plugins

EXPOSE 8080

CMD ["java", "-Xms512M", "-Xmx512M", "-jar", "/app/velocity.jar"]
