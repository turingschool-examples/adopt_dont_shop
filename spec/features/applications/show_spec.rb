require 'rails_helper'

RSpec.describe "the Application show page" do
  before :each do
    @shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @pet_1 = @shelter.pets.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: @shelter.id)
    @pet_2 = @shelter.pets.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: @shelter.id)
    @pet_3 = @shelter.pets.create!(adoptable: true, age: 5, breed: 'lab', name: 'Bear', shelter_id: @shelter.id)
    @application = Application.create!(name: "Bob Baker", address: "345 2nd St Denver, CO 80206", description: nil, status: "In progress")
    PetApplication.create!(application: @application, pet: @pet_1)
    PetApplication.create!(application: @application, pet: @pet_2)
  end

  it "should show application attribtes" do
    visit "/applications/#{@application.id}"

    expect(page).to have_content(@application.name)
    expect(page).to have_content(@application.address)
    expect(page).to have_content(@application.status)
    expect(page).to have_content(@pet_1.name)
    expect(page).to have_content(@pet_2.name)
  end

  it 'can search for pets by name' do
    visit "/applications/#{@application.id}"

    within('#search-pet') do
      fill_in with: "#{@pet_3.name}"
      click_on "Search"
    end

    expect(page).to have_content(@pet_3.name)
  end

  it 'can add pet to application' do
    visit "/applications/#{@application.id}"

    within('#search-pet') do
      fill_in with: "#{@pet_3.name}"
      click_on "Search"
    end

    within('#adopt-pet') do
     click_button "Adopt #{@pet_3.name}"
    end

    expect(current_path).to eq("/applications/#{@application.id}")
    expect(@pet_3.name).to appear_before('Search')
    expect(page).to have_content('No pets searched')
    expect(@application.pets).to include(@pet_3)
  end

  it 'can submit an application' do
    visit "/applications/#{@application.id}"

    within('#submit') do
      fill_in "Why I'd make a good home", with: "I'm chill. Need pets"
      click_on "Submit Application"
    end

    expect(current_path).to eq("/applications/#{@application.id}")
    expect(page).not_to have_content('Submit Application')
    # expect(@application.status).to eq('Pending')
  end
end
