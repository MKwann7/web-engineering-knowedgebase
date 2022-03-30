package controllers

import (
	"html/template"
	"log"
	"net/http"
)

type Student struct {

	// defining struct fields
	Name  string
	Marks int
	Id    string
}

func HomeControllerHandle(responseWriter http.ResponseWriter, webRequest *http.Request) {

	std1 := Student{"Vani", 94, "20024"}

	t, err := template.ParseFiles("/app/templates/index.html")

	if err != nil {
		log.Fatal("Can't find template file.")
	}

	responseWriter.Header().Set("Content-Type", "text/html; charset=utf-8")
	err = t.Execute(responseWriter, std1)
}
