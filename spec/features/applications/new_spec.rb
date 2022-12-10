require "rails_helper"

RSpec.describe "new application" do
  before (:each) do 
    shelter_1 = Shelter.create!(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    application_1 = Application.create!(name: 'Shaggy', street_address: '123 Mystery Lane', city: 'Denver', state: 'Colorado', zip_code: '80203', description: "I have snacks", status: "Pending")
    pet_1 = Pet.create!(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter_1.id)
    pet_2 = Pet.create!(name: 'Scrappy', age: 1, breed: 'Great Dane', adoptable: true, shelter_id: shelter_1.id)
    app_pet_1 = ApplicationPet.create!(pet_id: pet_1.id, application_id: application_1.id)
    app_pet_1 = ApplicationPet.create!(pet_id: pet_2.id, application_id: application_1.id)
  end

  it "application form" do
    visit "/pets"

    click_link "Start an Application"
    
   
    expect(page).to have_current_path("/applications/new")
    expect(find('form')).to have_content('Name')
    expect(find('form')).to have_content('Street Address')
    expect(find('form')).to have_content('City')
    expect(find('form')).to have_content('State')
    expect(find('form')).to have_content('Zipcode')
  end

  it "has a filled in application" do
    visit 'applications/new'

    fill_in('name', with: "Shaggy")
    fill_in('street_address', with: "123 Mystery Lane")
    fill_in('city', with: "Denver")
    fill_in('state', with: "Colorado")
    fill_in('zip_code', with: "80203")
    fill_in('description', with: "xxx")
  
    click_button("Submit Application")

    new_application = Application.last
    # save_and_open_page
    expect(current_path).to eq("/applications/#{new_application.id}")
  end

#   As a visitor
# When I visit the new application page
# And I fail to fill in any of the form fields
# And I click submit
# Then I am taken back to the new applications page
# And I see a message that I must fill in those fields.
  describe 'user story 3' do
    describe '/applications/new' do
      describe 'if I do not fill out application and click submit' do 
        it 'redirects me to the new application page and shows an error message' do
          visit '/applications/new'
         
          fill_in('name', with: "Shaggy")
       
          # require 'pry'; binding.pry
          click_button("Submit Application") 

          expect(current_path).to eq('/applications/new')
          expect(page).to have_content('Error: Please fill in all fields')
        end
      end
    end
  end
end