require 'sidekiq'
require 'sinatra'
require 'sinatra/activerecord'
require 'rack/handler/puma'
require './config/database'
require './models/exam'
require './lib/csv_importer_worker'

get '/tests' do
  content_type :json
  Exam.all.to_json
end

get '/tests/:token' do
  content_type :json
  Exam.where(exam_token: params[:token]).to_json
end

get '/' do
  File.read('index.html')
end

post '/import' do
  csv_content = params['file']['tempfile'].read
  CSVImporterWorker.perform_async(csv_content)
  content_type :json
  { status: 'success' }.to_json
end

unless defined?(Rake)
  Rack::Handler::Puma.run(
    Sinatra::Application,
    Port: 3000,
    Host: '0.0.0.0'
  )
end
