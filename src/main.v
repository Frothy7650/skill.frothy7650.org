module main

import db.sqlite
import veb
import os

__global (
  const string name = "idk yet"
)

pub struct Context {
  veb.Context
}

pub struct App{
  veb.StaticHandler
  db sqlite.DB
}

fn main()
{
  if os.exists("db.sqlite") { os.rm("db.sqlite")! }
  mut app := &App{
    db: sqlite.connect("db.sqlite")!
  }

  sql app.db {
		create table User
	}!

	first_article := User{
    name: "frothy"
    bio: "hello, i like V"
	}

	second_article := User{
		name: "echo"
    bio: "hello, i like men"
	}

	sql app.db {
		insert first_article into User
		insert second_article into User
	}!

  app.handle_static("static", true)!
  veb.run[App, Context](mut app, 8081)
}

@["/"]
pub fn (app &App) index(mut ctx Context) veb.Result {
  return $veb.html()
}

@["/signup"]
pub fn (app &App) signup(mut ctx Context) veb.Result {
  return $veb.html()
}

@["/users"]
pub fn (app &App) users(mut ctx Context) veb.Result {
  users := app.find_all_users()
  return $veb.html()
}
