module github.com/MKwann7/web-engineering-knowledgebase/app/api

go 1.18

require (
	github.com/go-sql-driver/mysql v1.6.0
	github.com/google/uuid v1.3.0
	github.com/gorilla/mux v1.8.0
	github.com/gorilla/websocket v1.5.0
	github.com/joho/godotenv v1.4.0
	github.com/lib/pq v1.2.0
	github.com/urfave/negroni v1.0.0
)

replace github.com/MKwann7/web-engineering-knowledgebase/app/api/src/code/controllers/healthcheck => ../api/src/code/controllers/healthcheck
