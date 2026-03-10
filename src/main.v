module main

import veb

pub struct Context {
  veb.Context
}

pub struct App{
  veb.StaticHandler
}

fn main()
{
  mut app := &App{}
  app.handle_static("static", true)!
  veb.run[App, Context](mut app, 8081)
}

@["/index"]
pub fn (app &App) index(mut ctx Context) veb.Result {
  return $veb.html()
}
