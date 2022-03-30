FROM golang:1.18-stretch

# Setup document root
RUN mkdir -p /app/code
RUN mkdir -p /app/templates
RUN mkdir -p /app/static
RUN mkdir -p /app/logs
RUN mkdir -p /app/k6
RUN mkdir -p /app/tmp

WORKDIR /app/code

COPY app/web/go.mod /app/code
COPY app/web/go.sum /app/code
COPY app/web/reflex.conf /app/code

RUN go mod download

RUN ["go", "install", "github.com/cespare/reflex@latest"]

COPY app/web/src src
COPY app/web/templates /app/templates
COPY app/web/static /app/static
COPY docker/env/web-local.env .env

EXPOSE 8080

ENTRYPOINT ["reflex", "-c", "./reflex.conf"]