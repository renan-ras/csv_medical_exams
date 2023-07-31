require 'spec_helper'

describe 'Faz upload de arquivo CSV', type: :feature, js: true do
  it 'e atualiza o banco de dados' do
    file_path = File.expand_path(File.join(File.dirname(__FILE__), '..', 'test_data', 'data1.csv'))

    visit '/'
    attach_file('file', file_path)
    click_button('Upload CSV')

    wait_for { Exam.count }.to eq(26)
  end

  it 'e não insere dados repetidos', type: :feature, js: true do
    file_path = File.join(File.dirname(__FILE__), '..', 'test_data', 'data1.csv')
    csv_content1 = File.read(file_path)
    CSVImporter.import(csv_content1)
    csv1_lines = csv_content1.each_line.count - 1

    original_stdout = $stdout
    $stdout = StringIO.new
    file_path = File.join(File.dirname(__FILE__), '..', 'test_data', 'data2.csv')
    csv_content2 = File.read(file_path)
    CSVImporter.import(csv_content2)
    csv2_lines = csv_content2.each_line.count - 1
    $stdout = original_stdout

    expect(csv1_lines).to eq(26)
    expect(csv2_lines).to eq(26)
    wait_for { Exam.count }.to eq(39)
  end
end
