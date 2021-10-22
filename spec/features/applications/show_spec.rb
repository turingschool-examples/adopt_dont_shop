require 'rails_helper'

RSpec.describe 'Applications Show Page' do
  it 'displays all of the applications attributes' do
    app = Application.create!(name: 'Jen', address: '123 Street Dr, Pittsburgh PA 15238', description: 'I love dogs', names_of_pets: 'Jason, Michael', status: 'Pending')
  
    visit "/application/#{app.id}"

    expect(page).to have_content('Jen')
    expect(page).to have_content('123 Street Dr, Pittsburgh PA 15238')
    expect(page).to have_content('I love dogs')
    expect(page).to have_content('Jason, Michael')
    expect(page).to have_content('Pending')
  end
end