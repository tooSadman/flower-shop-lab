package order

import (
	"database/sql"
	"fmt"
	"time"

	_ "github.com/lib/pq"
	log "github.com/sirupsen/logrus"
)

type Order struct {
	ID         int
	FlowerName string
	Customer   int
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
		var customer int
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
			log.Warn(err)
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
	customer int,
	price int,
	packing string,
	delivery string,
) (
	int,
	error,
) {
	var id int
	createDate := time.Now()
	err := db.QueryRow(`
	INSERT INTO orders(flower_name, customer, price,
	create_date, packing, delivery)
	VALUES($1, $2, $3, $4, $5, $6)
	RETURNING id
	`, flowerName,
		customer,
		price,
		createDate.Format("2006-01-2"),
		packing,
		delivery,
	).Scan(&id)

	return id, err
}

func GetOrderById(db *sql.DB, id int) Order {
	var flowerName string
	var customer int
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
		log.Warn(err)
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

func GetOrdersByCustomer(customer int, db *sql.DB) []Order {
	orders := []Order{}

	query := fmt.Sprintf(`
	SELECT id, flower_name, customer, price, 
	create_date, packing, delivery
	FROM orders where customer = %d
	`, customer)
	rows, err := db.Query(query)
	defer rows.Close()
	if err != nil {
		log.Warn(err)
	}

	for rows.Next() {
		var id int
		var flowerName string
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
			log.Warn(err)
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

	return orders
}
