require 'rails_helper'

RSpec.describe 'the application show' do
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

  it "shows the application and all it's attributes" do
    visit "/applications/#{@application.id}"

    expect(page).to have_content(@application.name)
    expect(page).to have_content(@application.description)
    expect(page).to have_content(@application.full_address)
    expect(page).to have_content(@application.status)
  end

  it "shows the application and all it's pets names as links" do
    visit "/applications/#{@application.id}"

    expect(page).to have_link(@pet_1.name)
    expect(page).to have_link(@pet_2.name)
    expect(page).to_not have_link(@pet_3.name)
    expect(page).to_not have_link(@pet_4.name)
  end

  it "clicks a pets name and is brought to that pet's show page" do
    visit "/applications/#{@application.id}"

    expect(page).to have_link(@pet_1.name)
    click_link('Bare-y Manilow')
    expect(page).to have_current_path("/pets/#{@pet_1.id}")
  end

  it "enters a name and returns matching pets" do
    visit "/applications/#{@application.id}"

    expect(page).to have_content("Add a Pet to this Application")
    fill_in('query', with: 'sYlV')
    click_on('Search')

    expect(page).to have_content(@pet_3.name)
    expect(page).to_not have_content(@pet_4.name)
  end
end
