require 'rails_helper'

RSpec.describe "Application show page" do
  before :each do
    @shelter = Shelter.create(name: 'Rescue Shelter', city: 'Denver, CO', foster_program: false, rank: 3)
    @pet1 = Pet.create(adoptable: true, age: 4, breed: 'doberman', name: 'Carson', shelter_id: @shelter.id)
    @pet2 = Pet.create(adoptable: true, age: 6, breed: 'rottweiler', name: 'Larry', shelter_id: @shelter.id)
    @application = Application.create(name: 'Devin', address: '123 East St', state: "Colorado", city: "Denver", zip: "80911")
  end

  it 'displays the applicant name, full address, description, name of all pets applied for and application status' do
    visit "/applications/#{@application.id}"

    expect(page).to have_content(@application.name)
    expect(page).to have_content(@application.address)
    expect(page).to have_content(@application.state)
    expect(page).to have_content(@application.city)
    expect(page).to have_content(@application.zip)
  end

  it 'can search for pets to add to application' do
    visit "/applications/#{@application.id}"

    within('#Add_pet') do
      expect(page).to have_content("Add a Pet to this Application")

      fill_in('Search by pet name', with: 'Carson')
      click_button('Submit')

      expect(current_path).to eq("/applications/#{@application.id}")
      expect(page).to have_content("Carson")
    end
  end

  it 'can search for partial matches to add to application' do
    visit "/applications/#{@application.id}"

    within('#Add_pet') do
      expect(page).to have_content("Add a Pet to this Application")

      fill_in('Search by pet name', with: 'Cars')
      click_button('Submit')

      expect(current_path).to eq("/applications/#{@application.id}")
      expect(page).to have_content("Carson")
    end
  end

  it 'can search for case insensitive matches to add to application' do
    visit "/applications/#{@application.id}"

    within('#Add_pet') do
      expect(page).to have_content("Add a Pet to this Application")

      fill_in('Search by pet name', with: 'carson')
      click_button('Submit')

      expect(current_path).to eq("/applications/#{@application.id}")
      expect(page).to have_content("Carson")
    end
  end
end