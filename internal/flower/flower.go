package flower

import (
	"database/sql"
	"log"

	_ "github.com/lib/pq"
)

type Flower struct {
	ID      int
	Name    string
	Picture string
	Price   int
}

func AllFlowers(db *sql.DB) ([]Flower, error) {
	flowers := []Flower{}

	rows, err := db.Query(`
	SELECT id, flower_name, picture, price 
	FROM flowers order by id
	`)
	defer rows.Close()
	if err != nil {
		log.Fatal(err)
	}
	for rows.Next() {
		var id int
		var name string
		var picture string
		var price int

		err = rows.Scan(&id, &name, &picture, &price)
		if err != nil {
			log.Fatal(err)
		}
		currentFlower := Flower{
			ID:      id,
			Name:    name,
			Picture: picture,
			Price:   price}
		flowers = append(flowers, currentFlower)
	}

	return flowers, err
}
