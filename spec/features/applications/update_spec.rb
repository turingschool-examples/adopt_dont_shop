require 'rails_helper'

RSpec.describe 'the application update' do
  before(:each) do
    @application = Application.create!(name: "Austin Moore", street_address: "9999 Imaginary Ave", city: "Laurel", state: "MD", zip_code: "99999", description: "I am very nice", full_address: "9999 Imaginary Ave, Laurel, MD 99999", status: :in_progress)
    @shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create!(name: 'Boulder shelter', city: 'Boulder, CO', foster_program: false, rank: 9)
    @pet_1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: @shelter.id)
    @pet_2 = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: @shelter.id)
    @pet_3 = Pet.create!(adoptable: true, age: 1, breed: 'domestic shorthair', name: 'Sylvester', shelter_id: @shelter_2.id)
    @pet_4 = Pet.create!(adoptable: true, age: 1, breed: 'orange tabby shorthair', name: 'Lasagna', shelter_id: @shelter.id)
    @pet_application = PetApplication.create!(pet: @pet_1, application: @application, approved: true)
    @pet_application = PetApplication.create!(pet: @pet_2, application: @application, approved: true)
  end

  it "clicks on a returned pet and the pet is added to the application" do
    visit "/applications/#{@application.id}"

    fill_in('query', with: 'Sylvester')
    click_on('Search')

    within "#add-pet-to-app" do
      expect(page).to have_content(@pet_3.name)
      expect(page).to have_link("Adopt #{@pet_3.name}")
    end

    click_on("Adopt #{@pet_3.name}")

    expect(page).to have_current_path("/applications/#{@application.id}")
    within "#add-pet-to-app" do
      expect(page).to_not have_content(@pet_3.name)
    end
    expect(page).to have_content(@pet_3.name)
  end
end
