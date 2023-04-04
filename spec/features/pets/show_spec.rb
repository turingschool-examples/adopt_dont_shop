require 'rails_helper'

RSpec.describe 'the shelter show' do
  it "shows the shelter and all it's attributes" do
    shelter = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    pet = Pet.create(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)

    visit "/pets/#{pet.id}"

    expect(page).to have_content(pet.name)
    expect(page).to have_content(pet.age)
    expect(page).to have_content(pet.adoptable)
    expect(page).to have_content(pet.breed)
    expect(page).to have_content(pet.shelter_name)
  end

  it "allows the user to delete a pet" do
    shelter = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    pet = Pet.create(name: 'Scrappy', age: 1, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)

    visit "/pets/#{pet.id}"
  
    click_on("Delete #{pet.name}")

    expect(page).to have_current_path('/pets')
    expect(page).to_not have_content(pet.name)
  end

  describe 'pet_adopted method' do
    before(:each) do
      @shelter_1 = Shelter.create!(foster_program: true, name: "Taj Mahal for Dogs", city: "Sky City", rank: 20)
      @pet_1 = @shelter_1.pets.create!(name: "Foster", age: 1000, breed: "dog", adoptable: true)
      @pet_2 = @shelter_1.pets.create!(name: "Bento", age: 23, breed: "dog")
      @pet_3 = @shelter_1.pets.create!(name: "Quiggle", age: 555,)
      @pet_4 = @shelter_1.pets.create!(name: "Simpleton", age: 80,)
      @pet_5 = @shelter_1.pets.create!(name: "Dragon", age: 400,)
      @application_1 = Application.create!(applicant_name: "Bob", street_address: "123 Home St", city: "Denver", state: "CO", zip_code: "80238", description: "I love animals", status: "Pending")
      @application_2 = Application.create!(applicant_name: "Nebula", street_address: "45 Hippy Avenue", city: "Portland", state: "OR", zip_code: "40009", description: "Animals deserve to be freed into the woods", status: "Pending")
      @application_3 = Application.create!(applicant_name: "Angry Tim", street_address: "94 Gun Street", city: "Dallas", state: "TX", zip_code: "60888", description: "Don't question me or my motives", status: "Pending")
      PetApplication.create!(pet_id: @pet_1.id, application_id: @application_1.id)
      PetApplication.create!(pet_id: @pet_3.id, application_id: @application_1.id)
      PetApplication.create!(pet_id: @pet_5.id, application_id: @application_1.id)
      PetApplication.create!(pet_id: @pet_2.id, application_id: @application_2.id)
      PetApplication.create!(pet_id: @pet_4.id, application_id: @application_2.id)
      PetApplication.create!(pet_id: @pet_4.id, application_id: @application_3.id)
      PetApplication.create!(pet_id: @pet_5.id, application_id: @application_3.id)
    end

    it 'show page better displays attributes of Pets' do
      visit "/pets/#{@pet_1.id}"

      save_and_open_page
      expect(page).to have_content("Breed: dog")
      expect(page).to have_content("Adoptable: true")
      expect(page).to have_content("Shelter: Taj Mahal for Dogs")
    end
  end
end
