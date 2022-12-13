require 'rails_helper' 

RSpec.describe 'application show' do
  let!(:shelter) { Shelter.create!(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)}
  let!(:application) { Application.create!(name: 'Joe', street_address: "123 street lane", city: "denver", state: "co", zip_code: "12345", status: "Pending" ) }
  let!(:application_2) { Application.create!(name: 'Bob', street_address: "789 street lane", city: "denver", state: "co", zip_code: "12345", status: "In Progress" ) }
  let!(:pet) { Pet.create!(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)}

  describe 'as a visitor' do
    it 'shows application attributes' do
      visit "/applications/#{application.id}"

      expect(page).to have_content(application.name)
      expect(page).to have_content(application.address)
      expect(page).to have_content(application.status)

    end

    it 'each pet has a button to adopt' do
      visit "/applications/#{application_2.id}"
      
      fill_in 'search', with: 'Scooby'

      click_button('Add a Pet to this Application')
      
      expect(page).to have_button("Adopt this Pet")

      click_button('Adopt this Pet')
      
      expect(current_path).to eq("/applications/#{application_2.id}")
      expect(application_2.pet_names.include?("Scooby")).to be true
    end
  end

  describe 'description and submit' do
    it 'reveals submit button once pet is linked' do
      visit "/applications/#{application_2.id}"
      
      expect(page).to have_content "In Progress"
      fill_in 'search', with: 'Scooby'
      click_button('Add a Pet to this Application')
      click_button('Adopt this Pet')

      expect(page).to have_content("Describe")
      
      fill_in("description", with: "because because because")
      
      expect(page).to have_button("Submit Application")
      
      click_button("Submit Application")
      expect(current_path).to eq("/applications/#{application_2.id}")
      expect(page).to have_content "Pending"
      expect(page).to have_content(application_2.pet_names)
      expect(page).to_not have_content("Add a pet to this Application")
    end
    
    it 'sad path for description and submit' do
      visit "/applications/#{application_2.id}"
      
      expect(page).to_not have_content("You must provide a description")

      fill_in 'search', with: 'Scooby'
      click_button('Add a Pet to this Application')
      click_button('Adopt this Pet')
      fill_in 'description', with: ""

      expect(page).to have_button("Submit Application")
      click_button("Submit Application")
    end
  end
end