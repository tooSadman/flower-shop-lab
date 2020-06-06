package apiserver

import (
	"database/sql"
	"encoding/json"
	"log"
	"net/http"

	"github.com/gorilla/mux"
	_ "github.com/lib/pq"
)

type server struct {
	db     *sql.DB
	Router *mux.Router
}

type user struct {
	ID                 int
	Email              string
	Encrypted_password string
	Username           string
}

func (s *server) routes() {
	s.Router.HandleFunc("/users", s.handleUsersGet())
}

func allUsers(s *server) ([]user, error) {
	users := []user{}

	rows, err := s.db.Query(`
	SELECT id, email, encrypted_password, username 
	FROM users order by id
	`)
	defer rows.Close()
	if err != nil {
		log.Fatal(err)
	}
	for rows.Next() {
		var id int
		var username string
		var email string
		var encrypted_password string

		err = rows.Scan(&id, &email, &encrypted_password, &username)
		if err != nil {
			log.Fatal(err)
		}
		currentUser := user{
			ID:                 id,
			Email:              email,
			Encrypted_password: encrypted_password,
			Username:           username}
		users = append(users, currentUser)
	}

	return users, err
}

func (s *server) handleUsersGet() http.HandlerFunc {
	users, _ := allUsers(s)
	return func(w http.ResponseWriter, r *http.Request) {
		json.NewEncoder(w).Encode(users)
	}
}

func NewServer() *server {
	s := server{}
	s.Router = mux.NewRouter()
	tmpDB, err := sql.Open(
		"postgres",
		"dbname=shop user=postgres password=mysecretpassword host=localhost sslmode=disable",
	)
	if err != nil {
		log.Fatal(err)
	}
	s.db = tmpDB
	s.routes()
	return &s
}
