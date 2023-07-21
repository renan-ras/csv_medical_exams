require 'csv'

class CSVImporter
  def self.import(path)
    CSV.foreach(path, headers: true, col_sep: "\t") do |row|
      Exam.create(row.to_hash)
    end
  end
end
