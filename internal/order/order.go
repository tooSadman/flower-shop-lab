package order

import (
	"database/sql"
	"log"
	"time"

	_ "github.com/lib/pq"
)

type Order struct {
	ID         int
	FlowerName string
	Customer   string
	Price      int
	CreateDate time.Time
	Packing    string
	Delivery   string
}

func AllOrders(db *sql.DB) ([]Order, error) {
	orders := []Order{}

	rows, err := db.Query(`
	SELECT id, flower_name, customer, price, create_date,
	packing, delivery
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
		var createDate time.Time
		var packing string
		var delivery string

		err = rows.Scan(
			&id,
			&flowerName,
			&customer,
			&price,
			&createDate,
			&packing,
			&delivery,
		)
		if err != nil {
			log.Fatal(err)
		}
		currentOrder := Order{
			ID:         id,
			FlowerName: flowerName,
			Customer:   customer,
			Price:      price,
			CreateDate: createDate,
			Packing:    packing,
			Delivery:   delivery,
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
	createDate time.Time,
	packing string,
	delivery string,
) (
	int,
	error,
) {
	var id int
	err := db.QueryRow(`
	INSERT INTO orders(flower_name, customer, price,
	create_date, packing, delivery)
	VALUES($1, $2, $3)
	RETURNING id
	`, flowerName, customer, price, createDate, packing, delivery).Scan(&id)

	return id, err
}

func GetOrderById(db *sql.DB, id int) Order {
	var flowerName string
	var customer string
	var price int
	var createDate time.Time
	var packing string
	var delivery string

	err := db.QueryRow(`
	SELECT id, flower_name, customer, price,
	create_date, packing, delivery
	FROM orders where id = $1
	`, id,
	).Scan(
		&id,
		&flowerName,
		&customer,
		&price,
		&createDate,
		&packing,
		&delivery,
	)
	if err != nil {
		log.Fatal(err)
	}
	order := Order{
		ID:         id,
		FlowerName: flowerName,
		Customer:   customer,
		Price:      price,
		CreateDate: createDate,
		Packing:    packing,
		Delivery:   delivery,
	}

	return order
}

func GetOrderByCustomer(customer string, db *sql.DB) Order {
	var id int
	var flowerName string
	var price int
	var createDate time.Time
	var packing string
	var delivery string

	err := db.QueryRow(`
	SELECT id, flower_name, customer, price, 
	create_date, packing, delivery
	FROM orders where customer = $1
	`, customer,
	).Scan(
		&id,
		&flowerName,
		&customer,
		&price,
		&createDate,
		&packing,
		&delivery,
	)
	if err != nil {
		log.Fatal(err)
	}
	order := Order{
		ID:         id,
		FlowerName: flowerName,
		Customer:   customer,
		Price:      price,
		CreateDate: createDate,
		Packing:    packing,
		Delivery:   delivery,
	}

	return order
}
