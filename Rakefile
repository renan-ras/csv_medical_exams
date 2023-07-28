require 'sinatra/activerecord/rake'
require './lib/csv_importer'
require './lib/csv_importer_worker'
require './config/database'

namespace :db do
  desc 'Import CSV data directly'
  task :import_sync do
    csv_content = File.read('./data.csv')
    CSVImporter.import(csv_content)
  end

  desc 'Import CSV data through worker'
  task :import_async do
    csv_content = File.read('./data.csv')
    CSVImporterWorker.perform_async(csv_content)
  end
end
