require 'active_record'

ActiveRecord::Base.establish_connection(
  adapter: 'postgresql',
  database: 'my_db',
  username: 'my_user',
  password: 'my_password',
  host: 'db'
)
