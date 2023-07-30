class Exam < ActiveRecord::Base
  validates :exam_token, uniqueness: { scope: :exam_type, message: 'Exame repetido' }
end
