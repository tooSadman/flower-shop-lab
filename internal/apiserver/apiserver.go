package apiserver

import (
	"database/sql"
	"encoding/json"
	"log"
	"net/http"

	"github.com/gorilla/mux"
	_ "github.com/lib/pq"
	"github.com/tooSadman/flower-shop-lab/internal/flower"
	"github.com/tooSadman/flower-shop-lab/internal/user"
)

type Server struct {
	DB     *sql.DB
	Router *mux.Router
}

func (s *Server) routes() {
	s.Router.HandleFunc("/flowers", s.handleFlowersGet())
	s.Router.HandleFunc("/users", s.handleUsersGet())
}

func (s *Server) handleFlowersGet() http.HandlerFunc {
	flowers, _ := flower.AllFlowers(s.DB)
	return func(w http.ResponseWriter, r *http.Request) {
		json.NewEncoder(w).Encode(flowers)
	}
}

func (s *Server) handleUsersGet() http.HandlerFunc {
	users, _ := user.AllUsers(s.DB)
	return func(w http.ResponseWriter, r *http.Request) {
		json.NewEncoder(w).Encode(users)
	}
}

func NewServer() *Server {
	s := Server{}
	s.Router = mux.NewRouter()
	tmpDB, err := sql.Open(
		"postgres",
		"dbname=shop user=postgres password=mysecretpassword host=localhost sslmode=disable",
	)
	if err != nil {
		log.Fatal(err)
	}
	s.DB = tmpDB
	s.routes()
	return &s
}
