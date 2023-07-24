require 'sinatra'
require 'sinatra/activerecord'
require 'rack/handler/puma'
require './config/database'
require './models/exam'

unless defined?(Rake)
  get '/tests' do
    content_type :json
    Exam.all.to_json
  end

  get '/' do
    File.read('index.html')
  end

  Rack::Handler::Puma.run(
    Sinatra::Application,
    Port: 3000,
    Host: '0.0.0.0'
  )
end
