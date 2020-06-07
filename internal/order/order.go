package order

import (
	"database/sql"
	"log"

	_ "github.com/lib/pq"
)

type Order struct {
	ID         int
	FlowerName string
	Customer   string
	Price      int
}

func AllOrders(db *sql.DB) ([]Order, error) {
	orders := []Order{}

	rows, err := db.Query(`
	SELECT id, flower_name, customer, price 
	FROM orders order by id
	`)
	defer rows.Close()
	if err != nil {
		log.Fatal(err)
	}
	for rows.Next() {
		var id int
		var flowerName string
		var customer string
		var price int

		err = rows.Scan(&id, &flowerName, &customer, &price)
		if err != nil {
			log.Fatal(err)
		}
		currentOrder := Order{
			ID:         id,
			FlowerName: flowerName,
			Customer:   customer,
			Price:      price,
		}
		orders = append(orders, currentOrder)
	}

	return orders, err
}

func CreateOrder(
	db *sql.DB,
	flowerName string,
	customer string,
	price int,
) (
	int,
	error,
) {
	var id int
	err := db.QueryRow(`
	INSERT INTO orders(flower_name, customer, price)
	VALUES($1, $2, $3)
	RETURNING id
	`, flowerName, customer, price).Scan(&id)

	return id, err
}

func GetOrderById(db *sql.DB, id int) Order {
	var flowerName string
	var customer string
	var price int

	err := db.QueryRow(`
	SELECT id, flower_name, customer, price 
	FROM orders where id = $1
	`, id,
	).Scan(&id, &flowerName, &customer, &price)
	if err != nil {
		log.Fatal(err)
	}
	order := Order{
		ID:         id,
		FlowerName: flowerName,
		Customer:   customer,
		Price:      price,
	}

	return order
}

func GetOrderByCustomer(customer string, db *sql.DB) Order {
	var id int
	var flowerName string
	var price int

	err := db.QueryRow(`
	SELECT id, flower_name, customer, price 
	FROM orders where customer = $1
	`, customer,
	).Scan(&id, &flowerName, &customer, &price)
	if err != nil {
		log.Fatal(err)
	}
	order := Order{
		ID:         id,
		FlowerName: flowerName,
		Customer:   customer,
		Price:      price,
	}

	return order
}
