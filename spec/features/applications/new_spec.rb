require 'rails_helper'

RSpec.describe 'Applications new view' do
  before :each do
    # app_info = (('Name', with: 'Oz')
    # ('Street address', with: 'Man')
    # ('City', with: 'Denver')
    # ('State', with: 'CO')
    # ('Zip code', with: '80025'))
  end

  it 'can create a new Application' do
    visit('/applications/new')

    fill_in('Name', with: 'Oz')
    fill_in('Street address', with: 'Man')
    fill_in('City', with: 'Denver')
    fill_in('State', with: 'CO')
    fill_in('Zip code', with: '80025')
    click_on('Submit')
    @app = Application.last.id
    expect(current_path).to eq("/applications/#{@app}")
    expect(page).to have_content('Oz')
    expect(page).to have_content('Man')
    expect(page).to have_content('Denver')
    expect(page).to have_content('CO')
    expect(page).to have_content('80025')
    expect(page).to have_content('In Progress')
  end
end
