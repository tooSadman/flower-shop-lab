package user

import (
	"database/sql"
	"log"

	_ "github.com/lib/pq"
)

type Card struct {
	ID       int
	CardName string
	Discount float64
}

type User struct {
	ID                int
	Email             string
	EncryptedPassword string
	Username          string
	Card              string
}

func AllUsers(db *sql.DB) ([]User, error) {
	users := []User{}

	rows, err := db.Query(`
	SELECT id, email, encrypted_password, username, card 
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
		var card string

		err = rows.Scan(
			&id,
			&email,
			&encrypted_password,
			&username,
			&card,
		)
		if err != nil {
			log.Fatal(err)
		}
		currentUser := User{
			ID:                id,
			Email:             email,
			EncryptedPassword: encrypted_password,
			Username:          username,
			Card:              card,
		}
		users = append(users, currentUser)
	}

	return users, err
}

func GetUserByID(id int, db *sql.DB) User {
	var email string
	var encrypted_password string
	var username string
	var card string

	err := db.QueryRow(`
	SELECT id, email, encrypted_password, username, card 
	FROM users where id = $1
	`, id,
	).Scan(&id, &email, &encrypted_password, &username, &card)
	if err != nil {
		log.Fatal(err)
	}
	user := User{
		ID:                id,
		Email:             email,
		EncryptedPassword: encrypted_password,
		Username:          username,
		Card:              card,
	}

	return user
}

func GetUserByEmail(email string, db *sql.DB) User {
	var id int
	var encrypted_password string
	var username string
	var card string

	err := db.QueryRow(`
	SELECT id, email, encrypted_password, username, card 
	FROM users where email = $1
	`, email,
	).Scan(&id, &email, &encrypted_password, &username, &card)
	if err != nil {
		log.Fatal(err)
	}
	user := User{
		ID:                id,
		Email:             email,
		EncryptedPassword: encrypted_password,
		Username:          username,
		Card:              card,
	}

	return user
}

func GetCardByName(cardName string, db *sql.DB) Card {
	var id int
	var discount float64

	err := db.QueryRow(`
	SELECT id, card_name, discount 
	FROM users where card_name = $1
	`, cardName,
	).Scan(&id, &cardName, &discount)
	if err != nil {
		log.Fatal(err)
	}
	card := Card{
		ID:       id,
		CardName: cardName,
		Discount: discount,
	}

	return card
}
