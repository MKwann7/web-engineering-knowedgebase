package main

import (
	"github.com/MKwann7/web-engineering-knowledgebase/app/web/src/code/controllers"
	"github.com/gorilla/mux"
	"github.com/joho/godotenv"
	"github.com/urfave/negroni"
	"log"
	"net/http"
	"os"
)

func main() {

	err := godotenv.Load()

	if err != nil {
		log.Fatal("Error loading .env file")
	}

	router := router()
	middleware := negroni.Classic()
	middleware.UseHandler(router)

	if os.Getenv("ENV") == "local" {
		router.Headers("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept, Methods")
		router.Headers("Access-Control-Allow-Origin", "*")
		router.Headers("Access-Control-Allow-Methods", "POST, GET, PUT, DELETE")
		router.Headers("Content-Type", "application/json charset=utf-8")
	}

	http.ListenAndServe(":"+os.Getenv("PORT_NUM"), corseHandler(middleware))
}

func router() *mux.Router {

	router := mux.NewRouter().StrictSlash(true)
	router.
		Methods("GET").
		Path("/health-check").
		HandlerFunc(controllers.HealthcheckControllerHandle)
	router.
		PathPrefix("/static/").
		Handler(http.StripPrefix("/static/", http.FileServer(http.Dir("/app/static/"))))
	router.
		Methods("GET").
		PathPrefix("/").
		HandlerFunc(controllers.HomeControllerHandle)

	return router
}

func corseHandler(handler http.Handler) http.HandlerFunc {
	return func(responseWriter http.ResponseWriter, webRequest *http.Request) {
		if webRequest.Method == "OPTIONS" {
			responseWriter.Header().Set("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept, Methods")
			responseWriter.Header().Set("Access-Control-Allow-Origin", "*")
			responseWriter.Header().Set("Access-Control-Allow-Methods", "POST, GET, PUT, DELETE")
			responseWriter.Header().Set("Content-Type", "application/json charset=utf-8")
		} else {

			if os.Getenv("ENV") == "local" {
				responseWriter.Header().Set("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept, Methods")
				responseWriter.Header().Set("Access-Control-Allow-Origin", "*")
				responseWriter.Header().Set("Access-Control-Allow-Methods", "POST, GET, PUT, DELETE")
				responseWriter.Header().Set("Content-Type", "application/json charset=utf-8")
			}
			handler.ServeHTTP(responseWriter, webRequest)
		}
	}
}
