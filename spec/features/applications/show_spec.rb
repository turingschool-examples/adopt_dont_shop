require 'rails_helper'



RSpec.describe 'Application Show Page' do

  before :each do
    @shelter_1 = Shelter.create!(foster_program: true, name: 'Pet-a-saurus', city: 'Arvada', rank: 17)
    @shelter_2 = Shelter.create!(foster_program: false, name: 'Petguins', city: 'Denver', rank: 12)

    @pet_1 = @shelter_1.pets.create!(adoptable: true, age: 3, breed: 'Newfoundland', name: 'Huey')
    @pet_2 = @shelter_1.pets.create!(adoptable: false, age: 7, breed: 'Bernese Mountain Dog', name: 'Watermelon')
    @pet_3 = @shelter_2.pets.create!(adoptable: true, age: 1, breed: 'Golden Retriever', name: 'Sir William Wallace')
    @pet_4 = @shelter_2.pets.create!(adoptable: true, age: 5, breed: 'Border Collie', name: 'Bobby Mounahan')

    @application_1 = Application.create!(name: 'Roald Marshallsen', state: 'Colorado', city: 'Arvada', address: '1744 N. Pole Ln.', zip_code: 80004, description: 'Im a cool guy', status: 'Pending')
    @application_2 = Application.create!(name: 'Matt Smith', state: 'Colorado', city: 'Westminster', address: '2314 Gamble Oak St.', zip_code: 80003, description: 'Because adopting is cool', status: 'In Progress')

    @pet_app_1 = PetApplication.create!(pet_id: @pet_1.id, application_id: @application_1.id)
    @pet_app_2 = PetApplication.create!(pet_id: @pet_2.id, application_id: @application_1.id)
    @pet_app_3 = PetApplication.create!(pet_id: @pet_3.id, application_id: @application_1.id)
    @pet_app_4 = PetApplication.create!(pet_id: @pet_1.id, application_id: @application_2.id)
    @pet_app_4 = PetApplication.create!(pet_id: @pet_4.id, application_id: @application_2.id)
  end

  it 'Shows the only the given applications attributes' do
    visit "/applications/#{@application_1.id}"

    expect(page).to have_content(@application_1.name)
    expect(page).to have_content(@application_1.address)
    expect(page).to have_content(@application_1.city)
    expect(page).to have_content(@application_1.state)
    expect(page).to have_content(@application_1.zip_code)
    expect(page).to have_content(@application_1.description)
    expect(page).to have_content(@application_1.status)
    expect(page).to have_content(@pet_1.name)
    expect(page).to have_content(@pet_2.name)
    expect(page).to have_content(@pet_3.name)

    expect(page).to_not have_content(@application_2.name)
  end

  it 'has a link to each pet' do
    visit "/applications/#{@application_1.id}"

    click_on "#{@pet_1.name}"

    expect(current_path).to eq("/pets/#{@pet_1.id}")
  end
end
