// article.v
module main

struct User {
	id    int @[primary; sql: serial]
	name    string
  bio     string
}

pub fn (app &App) find_all_users() []User {
	return sql app.db {
		select from User
	} or { panic(err) }
}
