require 'rails_helper' 

RSpec.describe 'application show' do
  let!(:shelter) { Shelter.create!(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)}
  let!(:application) { Application.create!(name: 'Joe', street_address: "123 street lane", city: "denver", state: "co", zip_code: "12345",  description: "I like dogs", pet_names: "kona", status: "pending" ) }
  let!(:application_2) { Application.create!(name: 'Bob', street_address: "789 street lane", city: "denver", state: "co", zip_code: "12345",  description: "I like dogs", pet_names: nil, status: "in progress" ) }
  let!(:pet) { Pet.create!(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)}
  describe 'as a visitor' do
    it 'shows application attributes' do
      visit "/applications/#{application.id}"

      expect(page).to have_content(application.name)
      expect(page).to have_content(application.address)
      expect(page).to have_content(application.description)
      expect(page).to have_content(application.pet_names)
      expect(page).to have_content(application.status)

    end

    #     As a visitor
    # When I visit an application's show page
    # And I search for a Pet by name
    # And I see the names Pets that match my search
    # Then next to each Pet's name I see a button to "Adopt this Pet"
    # When I click one of these buttons
    # Then I am taken back to the application show page
    # And I see the Pet I want to adopt listed on this application

    it 'each pet has a button to adopt' do
      visit "/applications/#{application_2.id}"
      
      fill_in 'search', with: 'Scooby'

      # save_and_open_page
      click_button('Add a Pet to this Application')
      
      expect(page).to have_button("Adopt this Pet")
      click_button('Adopt this Pet')
      expect(current_path).to eq("/applications/#{application_2.id}")
      expect(application_2.pet_names).to eq("Scooby")

    end
  end
end