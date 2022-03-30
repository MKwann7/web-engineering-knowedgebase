package controllers

import (
	"github.com/MKwann7/web-engineering-knowledgebase/app/web/src/code/libraries/helper"
	"net/http"
)

func HealthcheckControllerHandle(responseWriter http.ResponseWriter, webRequest *http.Request) {

	healthCheck := helper.TransactionBool{Success: true}
	helper.JsonReturn(healthCheck, responseWriter)
}
