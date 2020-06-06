package main

import (
	"net/http"

	"github.com/tooSadman/flower-shop-lab/internal/apiserver"
)

func main() {
	server := apiserver.NewServer()
	http.ListenAndServe(":9000", server.Router)
}
