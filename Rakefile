require 'sinatra/activerecord/rake'
require './lib/csv_importer'
require './config/database'

namespace :db do
  desc 'Import CSV data'
  task :import_csv do
    CSVImporter.import('./data.csv')
  end
end
