FROM golang:1.18-stretch

ENV GO111MODULE=on

# Setup document root
RUN mkdir -p /app/code
RUN mkdir -p /app/logs
RUN mkdir -p /app/k6
RUN mkdir -p /app/tmp

WORKDIR /app/code

COPY src/app/go.mod /app/code
#COPY go.sum /app/code
COPY src/app/reflex.conf /app/code

RUN go mod download

RUN ["go", "install", "github.com/cespare/reflex@latest"]

COPY src/app/src src
COPY docker/env/app-local.env .env

EXPOSE 8080

ENTRYPOINT ["reflex", "-c", "./reflex.conf"]