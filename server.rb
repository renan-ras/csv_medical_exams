require 'sinatra'
require 'active_record'
require 'sinatra/activerecord'
require 'rack/handler/puma'
# require './config/database'
require './models/exam'
# require './lib/csv_importer'

# CSVImporter.import('./data.csv')


# Estabeleça a conexão com o banco de dados
set :database, {
  adapter: 'postgresql',
  database: 'my_db',
  username: 'my_user',
  password: 'my_password',
  host: 'db'
}

# Carregue o arquivo de migração
# require './db/migrate/001_create_exams.rb'

# # Execute a migração
# ActiveRecord::Migration.verbose = true
# CreateExams.new.change



unless defined?(Rake)
  get '/tests' do
    Exam.all.to_json
  end

  Rack::Handler::Puma.run(
    Sinatra::Application,
    Port: 3000,
    Host: '0.0.0.0'
  )
end
