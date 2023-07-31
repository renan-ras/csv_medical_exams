require 'spec_helper'

describe "Clica no botão 'Mostrar todos'", type: :feature, js: true do
  it 'e vê página em branco' do
    visit '/'
    # page.execute_script("document.getElementById('show-all').click();")
    click_button 'Mostrar todos'

    expect(page).to_not have_content 'hemácias'
    expect(page).to_not have_content 'leucócitos'
    expect(page).to_not have_content 'plaquetas'
    expect(page).to_not have_content 'hdl'
    expect(page).to_not have_content 'ldl'
    expect(page).to_not have_content 'vldl'
    expect(page).to_not have_content 'glicemia'
    expect(page).to_not have_content 'tgo'
    expect(page).to_not have_content 'tgp'
    expect(page).to_not have_content 'eletrólitos'
    expect(page).to_not have_content 'tsh'
    expect(page).to_not have_content 't4-livre'
    expect(page).to_not have_content 'ácido úrico'
  end

  it 'e vê dados carregados' do
    file_path = File.join(File.dirname(__FILE__), '..', 'test_data', 'data1.csv')
    csv_content = File.read(file_path)
    CSVImporter.import(csv_content)

    visit '/'
    # page.execute_script("document.getElementById('show-all').click();")
    click_button 'Mostrar todos'

    expect(page).to have_content 'NHBG56'
    expect(page).to have_content 'KLCM98'
    expect(page).to have_content '672.432.850-15'
    expect(page).to have_content '191.834.690-32'
    expect(page).to have_content 'hemácias'
    expect(page).to have_content 'leucócitos'
    expect(page).to have_content 'plaquetas'
    expect(page).to have_content 'hdl'
    expect(page).to have_content 'ldl'
    expect(page).to have_content 'vldl'
    expect(page).to have_content 'glicemia'
    expect(page).to have_content 'tgo'
    expect(page).to have_content 'tgp'
    expect(page).to have_content 'eletrólitos'
    expect(page).to have_content 'tsh'
    expect(page).to have_content 't4-livre'
    expect(page).to have_content 'ácido úrico'
  end

  it 'e vê paginação' do
    file_path = File.join(File.dirname(__FILE__), '..', 'test_data', 'data3.csv')
    csv_content = File.read(file_path)
    CSVImporter.import(csv_content)

    visit '/'
    # page.execute_script("document.getElementById('show-all').click();")
    click_button 'Mostrar todos'

    expect(page).to have_selector('#pagination button', wait: 10)
    expect(page).to have_button('Anterior', disabled: true)
    expect(page).to have_button('Próximo')
    expect(page).to have_button('1', disabled: true)
    expect(page).to have_button('2')
  end
end
