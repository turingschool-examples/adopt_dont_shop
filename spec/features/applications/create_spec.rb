require 'rails_helper'

RSpec.describe 'application creation' do

  it 'create application' do
    @application_joe = Application.create!(name: 'Joe', address: '5555 Pine St', city: 'Boulder', state: 'Colorado', zip: '80304', description: 'animal lover', status: 'In Progress')
    visit "/applications/#{@application_joe.id}"
  end


  it 'create application' do
    visit "/pets"
    click_on 'Start an application'
    expect(page).to have_current_path('/applications/new')
    fill_in('name', with: 'Croix')
    fill_in('address', with: '5555')
    fill_in('city', with: 'Denver')
    fill_in('state', with: 'CO')
    fill_in('zip', with: '55055')
    fill_in('description', with: 'description test')
    fill_in('status', with: 'status test')

    click_on 'Create new application'
    # save_and_open_page
    # binding.pry
    application = Application.find_by(name: 'Croix')
    expect(page).to have_current_path("/applications/#{application.id}")
  end

end
