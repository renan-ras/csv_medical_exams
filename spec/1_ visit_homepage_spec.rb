require 'spec_helper'

describe 'Visita página inicial', type: :feature, js: true do
  it 'e vê os principais elementos' do
    visit '/'

    expect(page).to have_content 'Lista de exames'
    expect(page).to have_button 'Upload CSV'
    expect(page).to have_field 'Digite o token do exame'
    expect(page).to have_content 'Pesquisar'
    expect(page).to have_content 'Mostrar todos'
  end
end
