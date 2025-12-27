FROM eclipse-temurin:17-jre

WORKDIR /app

# tools for downloading + validating
RUN apt-get update \
  && apt-get install -y curl unzip \
  && rm -rf /var/lib/apt/lists/*

# Download Velocity (update BUILD if needed)
# Current shown on PaperMC downloads page: 3.4.0-SNAPSHOT build 558 :contentReference[oaicite:1]{index=1}
RUN curl -fL --retry 5 --retry-delay 2 \
  -o /app/velocity.jar \
  "https://api.papermc.io/v2/projects/velocity/versions/3.4.0-SNAPSHOT/builds/558/downloads/velocity-3.4.0-SNAPSHOT-558.jar" \
  && unzip -t /app/velocity.jar > /dev/null

# Your config + plugins
COPY velocity.toml /app/velocity.toml
COPY plugins /app/plugins

EXPOSE 8080

CMD ["java", "-Xms512M", "-Xmx512M", "-jar", "/app/velocity.jar"]
