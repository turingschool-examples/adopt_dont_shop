require 'rails_helper'

RSpec.describe 'show application' do
  it "shows the applications and all the attributes" do
    application = Application.create!(name: 'Jeremy', street_address: '111 Nonya Ave', city: 'Denver', state: 'CO', zipcode: '80201', description: 'Dogs are rad', status: 'In Progress')
    shelter = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    pet = Pet.create(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)

    visit "/applications/#{application.id}"

    expect(page).to have_content('Jeremy')
    expect(page).to have_content('111 Nonya Ave')
    expect(page).to have_content('Denver')
    expect(page).to have_content('CO')
    expect(page).to have_content('80201')
    expect(page).to have_content('Dogs are rad')
    expect(page).to have_content('In Progress')

    expect(page).to have_link('Scooby')
  end


end
