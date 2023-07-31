require 'spec_helper'

describe 'Busca de exame por token', type: :feature, js: true do
  it 'e vê dados específicos' do
    file_path = File.join(File.dirname(__FILE__), '..', 'test_data', 'data1.csv')
    csv_content = File.read(file_path)
    CSVImporter.import(csv_content)

    visit '/'
    fill_in 'search-token', with: 'NHBG56'
    click_button('Pesquisar')

    expect(page).to have_content 'Exame token: NHBG56'
    expect(page).to have_content 'Isabela Fernandes Souza'
    expect(page).to have_content 'CPF: 672.432.850-15'
    expect(page).to have_content 'Endereço: 456 Rua dos Sonhos, Rio de Janeiro/Rio de Janeiro'
    expect(page).to have_content 'Data de nascimento: 02/11/1990'
    expect(page).to have_content 'Médico(a) responsável: Fernanda Rodrigues - fernanda.rodrigues@email.com'
    expect(page).to have_content 'CRM: D598ER78P / RJ'
    expect(page).to have_content 'Data do exame: 10/07/2023'
  end
end
