package main

import (
	"flag"
	"log"
	"net/http"

	"github.com/BurntSushi/toml"
	"github.com/tooSadman/flower-shop-lab/internal/apiserver"
	"github.com/tooSadman/flower-shop-lab/internal/configs"
)

var (
	configPath string
)

func init() {
	flag.StringVar(&configPath, "config-path", "configs/apiserver.toml", "path to config file")
}

func main() {
	flag.Parse()

	config := configs.NewApiServerConfig()
	_, err := toml.DecodeFile(configPath, config)
	if err != nil {
		log.Fatal(err)
	}

	server := apiserver.NewServer()
	http.ListenAndServe(config.BindAddr, server.Router)
}
