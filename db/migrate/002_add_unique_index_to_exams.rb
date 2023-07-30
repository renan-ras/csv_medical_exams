class AddUniqueIndexToExams < ActiveRecord::Migration[7.0]
  def change
    add_index :exams, [:exam_token, :exam_type], unique: true
  end
end
