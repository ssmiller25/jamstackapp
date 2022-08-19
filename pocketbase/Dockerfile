FROM alpine:3.16

ARG POCKETBASE_VERSION=0.4.2

RUN mkdir -p /app/pb_data && cd /app && \
  apk add --no-cache curl && \
  curl -LO https://github.com/pocketbase/pocketbase/releases/download/v${POCKETBASE_VERSION}/pocketbase_${POCKETBASE_VERSION}_linux_amd64.zip && \
  unzip pocketbase_${POCKETBASE_VERSION}_linux_amd64.zip && \
  chmod 755 pocketbase && \
  rm pocketbase_${POCKETBASE_VERSION}_linux_amd64.zip && \
  apk del --no-cache curl

VOLUME ["/app/pbdata"]

ENTRYPOINT ["/app/pocketbase", "serve", "--http", "0.0.0.0:8090"]

EXPOSE 8090
