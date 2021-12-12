require 'rails_helper'

describe "Application Show" do
  before :each do
    @shelter = Shelter.create(name: 'Rescue Shelter', city: 'Denver, CO', foster_program: false, rank: 3)
    @pet1 = Pet.create(adoptable: true, age: 4, breed: 'doberman', name: 'Carson', shelter_id: @shelter.id)
    @pet2 = Pet.create(adoptable: true, age: 6, breed: 'rottweiler', name: 'Larry', shelter_id: @shelter.id)
    @application = Application.create(name: 'Devin', address: '123 East St', state: "Colorado", city: "Denver", zip: "80911")
    visit "/applications/#{@application.id}"
  end

  describe 'display' do
    it 'applicant name, full address, description, name of all pets applied for and application status' do
      expect(page).to have_content(@application.name)
      expect(page).to have_content(@application.address)
      expect(page).to have_content(@application.state)
      expect(page).to have_content(@application.city)
      expect(page).to have_content(@application.zip)
    end
  end

  describe 'search for pets' do
    it 'can search for a pet to add to application' do
      within('#Add_pet') do
        expect(page).to have_content("Add a Pet to this Application")

        fill_in('Search by pet name', with: 'Carson')
        click_button('Submit')

        expect(current_path).to eq("/applications/#{@application.id}")
        expect(page).to have_content("Carson")
      end
    end

    it 'can search for partial matches to add to application' do
      within('#Add_pet') do
        expect(page).to have_content("Add a Pet to this Application")

        fill_in('Search by pet name', with: 'Cars')
        click_button('Submit')

        expect(current_path).to eq("/applications/#{@application.id}")
        expect(page).to have_content("Carson")
      end
    end

    it 'can search for case insensitive matches to add to application' do
      within('#Add_pet') do
        expect(page).to have_content("Add a Pet to this Application")

        fill_in('Search by pet name', with: 'cArSo')
        click_button('Submit')

        expect(current_path).to eq("/applications/#{@application.id}")
        expect(page).to have_content("Carson")
      end
    end
  end

  describe 'Adding pet from search' do
    it 'has a button to adopt pet next to pets from search results' do
      within('#Add_pet') do
        expect(page).to have_content("Add a Pet to this Application")

        fill_in('Search by pet name', with: 'Carson')
        click_button('Submit')

        expect(current_path).to eq("/applications/#{@application.id}")

        click_button('Adopt this Pet')

        expect(current_path).to eq("/applications/#{@application.id}")
      end

      within('#Application_details') do
        expect(page).to have_content("Carson")
      end
    end
  end

  describe 'Submitting an Application' do
    it 'has a submit section once you have added pets to application' do
      within('#Add_pet') do
        expect(page).to have_content("Add a Pet to this Application")
        expect(page).to_not have_content("Submit my Application")

        fill_in('Search by pet name', with: 'Carson')
        click_button('Submit')

        expect(current_path).to eq("/applications/#{@application.id}")

        click_button('Adopt this Pet')
        expect(current_path).to eq("/applications/#{@application.id}")
      end

      within('#Submit_application') do
        expect(page).to have_content("Submit Application")

        fill_in('Description', with: 'I like degs')
        click_button("Submit My Application")

        expect(current_path).to eq("/applications/#{@application.id}")
      end

      expect(page).to have_content("Pending")
      expect(page).to_not have_content("Submit My Application")
      expect(page).to_not have_content("Add a Pet to this Application")
    end
  end
end