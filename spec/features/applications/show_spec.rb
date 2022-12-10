require 'rails_helper' 

RSpec.describe 'application show' do
  let!(:application) { Application.create!(name: 'Joe', street_address: "123 street lane", city: "denver", state: "co", zip_code: "12345",  description: "I like dogs", pet_names: "kona", status: "pending" ) }
  let!(:application_2) { Application.create!(name: 'Bob', street_address: "789 street lane", city: "denver", state: "co", zip_code: "12345",  description: "I like dogs", pet_names: nil, status: "in progress" ) }
    let!(:pe_1) { Pet.create!(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)}
  let!(:pet_2) { Pet.create!(name: 'Scoobyroo', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)}
  let!(:pet_3) { Pet.create!(name: 'Scoo', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)}
  let!(:pet_4) { Pet.create!(name: 'Jerry', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)}
  let!(:application) { Application.create!(name: 'Joe', street_address: "123 street lane", city: "denver", state: "co", zip_code: "12345",  description: "I like dogs", pet_names: "kona", status: "pending" ) }

  
  describe 'as a visitor' do
    it 'shows application attributes' do
      visit "/applications/#{application.id}"

      expect(page).to have_content(application.name)
      expect(page).to have_content(application.address)
      expect(page).to have_content(application.description)
      expect(page).to have_content(application.pet_names)
      expect(page).to have_content(application.status)

    end

    it 'allows a pet to be selected and added to application as an ApplicationPet' do
      # When I visit an application's show page
      visit "/applications/#{application.id}"
      # And I search for a Pet by name
      fill_in "search", with: 'Scooby'
      click_button('Add a Pet to this Application')
      # And I see the names Pets that match my search
      has_button?("Adopt this Pet")
      # Then next to each Pet's name I see a button to "Adopt this Pet"
      # When I click one of these buttons
      within "#{pet_2.id}" click_button "Adopt this Pet"
      # Then I am taken back to the application show page
      expect(current_path).to eq("/applications/#{application.id}")
      # And I see the Pet I want to adopt listed on this application
      expect(page).to have_content pet_2.name
    end
  end
end