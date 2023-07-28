require 'sinatra/activerecord'
require './config/database'
require 'sidekiq'
require_relative 'csv_importer'

# Worker Sidekiq
class CSVImporterWorker
  include Sidekiq::Worker

  def perform(csv_content)
    CSVImporter.import(csv_content)
  end
end
