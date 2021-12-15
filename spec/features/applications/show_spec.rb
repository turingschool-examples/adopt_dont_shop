require 'rails_helper'

RSpec.describe 'application show page' do
  before :each do
    @applicant_1 = Application.create!(name: "Betty", address: "123 Sesame Street", state: "WA", city: "Seattle", zip: "12345", description: "Many friendly muppets", status: "Pending")
  end

  it 'goes to show page' do

    shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    pet_1 = @applicant_1.pets.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
    pet_2 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)

    visit "/applications/#{@applicant_1.id}"

    expect(page).to have_content(@applicant_1.name)
    expect(page).to have_content(@applicant_1.address)
    expect(page).to have_content(@applicant_1.state)
    expect(page).to have_content(@applicant_1.city)
    expect(page).to have_content(@applicant_1.zip)
    expect(page).to have_content(@applicant_1.description)
    expect(page).to have_content(@applicant_1.status)
    expect(page).to have_content(pet_1.name)

    click_on(pet_1.name)

    expect(current_path).to eq("/pets/#{pet_1.id}")
  end
  
end
