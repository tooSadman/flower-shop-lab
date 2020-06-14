package apiserver

import (
	"database/sql"
	"encoding/json"
	"fmt"
	"log"
	"net/http"
	"strconv"

	"github.com/gorilla/mux"
	_ "github.com/lib/pq"
	"github.com/tooSadman/flower-shop-lab/internal/flower"
	"github.com/tooSadman/flower-shop-lab/internal/order"
	"github.com/tooSadman/flower-shop-lab/internal/user"
)

type Server struct {
	DB     *sql.DB
	Router *mux.Router
}

func (s *Server) routes() {
	s.Router.HandleFunc("/flowers/{cardName}", s.handleCardByName()).Methods("GET")
	s.Router.HandleFunc("/flowers", s.handleFlowersGet()).Methods("GET")
	s.Router.HandleFunc("/flowers/{id}", s.handleFlowerByIdGet()).Methods("GET")
	s.Router.HandleFunc("/orders", s.handleOrdersGet()).Methods("GET")
	s.Router.HandleFunc("/orders/create", s.handleOrderPost()).Methods("POST")
	s.Router.HandleFunc("/users", s.handleUsersGet()).Methods("GET")
	s.Router.HandleFunc("/users/{email}", s.handleUserByEmailGet()).Methods("GET")
	s.Router.HandleFunc("/users/{id}", s.handleUserByIdGet()).Methods("GET")
}

func (s *Server) handleCardByName() http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Content-Type", "application/json")
		params := mux.Vars(r)
		cardName := params["cardName"]
		card := user.GetCardByName(cardName, s.DB)
		json.NewEncoder(w).Encode(card)
	}
}

func (s *Server) handleFlowersGet() http.HandlerFunc {
	flowers, _ := flower.AllFlowers(s.DB)
	return func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Content-Type", "application/json")
		json.NewEncoder(w).Encode(flowers)
	}
}

func (s *Server) handleFlowerByIdGet() http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		w.Header().Set("Content-Type", "application/json")
		params := mux.Vars(r)
		id, _ := strconv.Atoi(params["id"])
		flower := flower.GetFlower(id, s.DB)
		json.NewEncoder(w).Encode(flower)
	}
}

func (s *Server) handleOrdersGet() http.HandlerFunc {
	orders, _ := order.AllOrders(s.DB)
	return func(w http.ResponseWriter, r *http.Request) {
		json.NewEncoder(w).Encode(orders)
	}
}

func (s *Server) handleOrderPost() http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		r.ParseForm()
		params := r.PostForm
		flowerName := params.Get("flowerName")
		customer := params.Get("customer")
		price, _ := strconv.Atoi(params.Get("price"))
		packing := params.Get("packing")
		delivery := params.Get("delivery")
		id, err := order.CreateOrder(
			s.DB,
			flowerName,
			customer,
			price,
			packing,
			delivery,
		)
		if err != nil {
			log.Fatalln(w, err)
		}
		fmt.Fprintf(w, "Order №%d was created!", id)
	}
}

func (s *Server) handleUsersGet() http.HandlerFunc {
	users, _ := user.AllUsers(s.DB)
	return func(w http.ResponseWriter, r *http.Request) {
		json.NewEncoder(w).Encode(users)
	}
}

func (s *Server) handleUserByIdGet() http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		params := mux.Vars(r)
		id, _ := strconv.Atoi(params["id"])
		user := user.GetUserByID(id, s.DB)
		json.NewEncoder(w).Encode(user)
	}
}

func (s *Server) handleUserByEmailGet() http.HandlerFunc {
	return func(w http.ResponseWriter, r *http.Request) {
		params := mux.Vars(r)
		email := params["email"]
		user := user.GetUserByEmail(email, s.DB)
		json.NewEncoder(w).Encode(user)
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
