package user

import (
	"database/sql"
	"log"

	_ "github.com/lib/pq"
)

type User struct {
	ID                 int
	Email              string
	Encrypted_password string
	Username           string
}

func AllUsers(db *sql.DB) ([]User, error) {
	users := []User{}

	rows, err := db.Query(`
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
		currentUser := User{
			ID:                 id,
			Email:              email,
			Encrypted_password: encrypted_password,
			Username:           username}
		users = append(users, currentUser)
	}

	return users, err
}
