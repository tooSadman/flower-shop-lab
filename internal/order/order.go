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
			Price:      price}
		orders = append(orders, currentOrder)
	}

	return orders, err
}
