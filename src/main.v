module main

import x.vweb
import x.json2
import rand

pub struct Context {
	vweb.Context
}

pub struct App {}

pub struct User {
	name string
	age  int
}

pub fn (app &App) index(mut ctx Context) vweb.Result {
	return ctx.text('Hello, World... from a V API!')
}

@['/json']
pub fn (app &App) json(mut ctx Context) vweb.Result {
	return ctx.json(User{
		name: 'The Response'
		age: 42
	})
}

@['/jsonstring']
pub fn (app &App) jsonstring(mut ctx Context) vweb.Result {
	mut me := map[string]json2.Any{}
	me['name'] = 'Bob'
	me['age'] = 18

	mut arr := []json2.Any{}
	arr << 'rock'
	arr << 'papers'
	arr << json2.null
	arr << 12

	me['interests'] = arr

	mut pets := map[string]json2.Any{}
	pets['Sam'] = 'Maltese Shitzu'
	me['pets'] = pets

	return ctx.text(me.str())
}

@['/password/']
pub fn (app &App) password(mut ctx Context) vweb.Result {
	mut length := 32
	if ctx.query['length'] != "" && ctx.query['length'].int() > 0 && ctx.query['length'].int() < 1000{
		length = ctx.query['length'].int()
	}

	return ctx.text(passgen(length))
}

@['/password/:length']
pub fn (app &App) passwordlength(mut ctx Context, asked_length int) vweb.Result {
	mut length := 32

	if asked_length > 0 && asked_length < 1000{
		length = asked_length
	}

	return ctx.text(passgen(length))
}

@['/:path']
pub fn (app &App) with_parameter(mut ctx Context, path string) vweb.Result {
	return ctx.text('with_parameter, path: "${path}"')
}

fn passgen(length int) string {
	chars := "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789!@#$%^&*()_+"
	mut password := []u8{len: length, init: 0}
	
	for i in 0 .. length {
		index := rand.intn(chars.len) or { return 'Error generating password'}
		password[i] = chars[index]
	}

	return password.bytestr()
}

fn main() {
	mut app := &App{}
	port := 8080
	
	vweb.run[App, Context](mut app, port)
}
