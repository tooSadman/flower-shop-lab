package configs

type ApiServerConfig struct {
        BindAddr        string `toml:"bind_addr"`
}

func NewApiServerConfig() *ApiServerConfig {
        return &ApiServerConfig{}
}

