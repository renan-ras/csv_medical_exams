require 'csv'
require './models/exam'

class CSVImporter
  CSV_TO_MODEL_MAP = {
    'cpf' => 'cpf',
    'nome paciente' => 'patient_name',
    'email paciente' => 'patient_email',
    'data nascimento paciente' => 'patient_birthdate',
    'endereço paciente' => 'patient_address',
    'cidade paciente' => 'patient_city',
    'estado paciente' => 'patient_state',
    'crm médico' => 'doctor_crm',
    'crm médico estado' => 'doctor_crm_state',
    'nome médico' => 'doctor_name',
    'email médico' => 'doctor_email',
    'token resultado exame' => 'exam_token',
    'data exame' => 'exam_date',
    'tipo exame' => 'exam_type',
    'limites tipo exame' => 'exam_limits',
    'resultado tipo exame' => 'exam_result',
  }.freeze

  def self.import(path)
    CSV.foreach(path, headers: true, col_sep: ';') do |row|
      exam_attributes = row.to_hash.transform_keys { |key| CSV_TO_MODEL_MAP[key] }
      Exam.create(exam_attributes)
    end
  end
end
