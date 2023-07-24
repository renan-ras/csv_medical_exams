require 'sinatra'
require 'sinatra/activerecord'

set :database, {
  adapter: 'postgresql',
  database: 'my_db',
  username: 'my_user',
  password: 'my_password',
  host: 'db'
}
