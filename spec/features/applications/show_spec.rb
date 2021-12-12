require 'rails_helper'

RSpec.describe 'the applications show page' do
  it "shows the applications and all it's attributes" do
    shelter = Shelter.create!(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    pet_1 = Pet.create!(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
    pet_2 = Pet.create!(name: 'Lobster', age: 3, breed: 'Doberman', adoptable: true, shelter_id: shelter.id)
    application = pet_1.applications.create(name: 'Frank', street_address: '123 Main St', city: 'Long Beach', state: 'CA', zipcode: '90712', description: 'I have a fully fenced in acre property', status: 'pending')
    AdoptablePet.create!(application: application, pet: pet_2)
    visit "/applications/#{application.id}"
    save_and_open_page
    expect(page).to have_content(application.name)
    expect(page).to have_content(application.street_address)
    expect(page).to have_content(application.description)
    expect(page).to have_content(application.status)
    find_link("#{pet_1.name}")
    find_link("#{pet_2.name}")
  end
end
