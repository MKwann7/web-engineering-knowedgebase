package healthcheck

import (
	"github.com/MKwann7/web-engineering-knowledgebase/src/app/src/code/libraries/helper"
	"net/http"
)

func HandleHealthCheck(responseWriter http.ResponseWriter, webRequest *http.Request) {

	healthCheck := helper.TransactionBool{Success: true}
	helper.JsonReturn(healthCheck, responseWriter)
}
