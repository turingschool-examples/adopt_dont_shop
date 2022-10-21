equire 'rails_helper'

RSpec.describe 'the application index' do
  before(:each) do
    shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @pet_1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
    @pet_2 = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)
    @app_1 = Application.create!(first: "Joe", last: "Hilby", street: "1234 N A St", city: "Any Town", state: "AnyState", zip: "12345", description: "So cute!", status: "In Progress")
    ApplicationPet.create!(pet: @pet_1, application: @app_1)
    ApplicationPet.create!(pet: @pet_2, application: @app_1)
  end

  it 'lists all the applications with their attributes' do
    visit "/applications"
    save_and_open_page
    expect(page).to have_content(@pet_1.name)
    expect(page).to have_content(@pet_2.name)
  end
end