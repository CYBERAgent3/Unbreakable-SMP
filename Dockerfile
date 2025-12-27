FROM eclipse-temurin:17-jre

WORKDIR /app

# tools: curl = download, jq = parse JSON, unzip = validate jar
RUN apt-get update \
  && apt-get install -y curl jq unzip \
  && rm -rf /var/lib/apt/lists/*

# Download latest STABLE Velocity (no hardcoded build numbers)
RUN set -eux; \
  URL="$(curl -s https://fill.papermc.io/v3/projects/velocity \
    | jq -r '.versions | to_entries[] | .value[]' \
    | sort -V -r \
    | while read -r VER; do \
        curl -s "https://fill.papermc.io/v3/projects/velocity/versions/${VER}/builds" \
        | jq -r 'first(.[] | select(.channel=="STABLE") | .downloads."server:default".url) // empty' \
        | head -n 1; \
      done \
    | head -n 1)"; \
  echo "Downloading Velocity from: $URL"; \
  curl -fL --retry 5 --retry-delay 2 -o /app/velocity.jar "$URL"; \
  unzip -t /app/velocity.jar > /dev/null

COPY velocity.toml /app/velocity.toml
COPY plugins /app/plugins

EXPOSE 8080

CMD ["java", "-Xms512M", "-Xmx512M", "-jar", "/app/velocity.jar"]
