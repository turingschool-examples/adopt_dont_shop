require 'rails_helper'

# Then I can see the following:
# - Name of the Applicant
# - Full Address of the Applicant including street address, city, state, and zip code
# - Description of why the applicant says they'd be a good home for this pet(s)
# - names of all pets that this application is for (all names of pets should be links to their show page)
# - The Application's status, either "In Progress", "Pending", "Accepted", or "Rejected"

RSpec.describe 'application show page', type: :feature do
  describe 'As a visitor' do
    before :each do
      @shelter = Shelter.create!(name: "Happy Paws Shelter", foster_program: true, city: "Denver", rank: 5)
      @pet = @shelter.pets.create!(name: "Fluffy", adoptable: true, age: 3, breed: "doberman")
      @application = Application.create!(name: "Samantha Smith", street_address: "123 Mulberry Street", city: "Denver", state: "CO", zip_code: 20202, description: "I would like this dog for these reasons.", status: "In Progress")
      @pet_application1 = PetApplication.create!(pet: @pet, application: @application)
    end
    it 'I can see all attributes of the application' do
      visit "/application/#{@application.id}"

      expect(page).to have_content('Samantha Smith')
      expect(page).to have_content('123 Mulberry Street')
      expect(page).to have_content('Denver')
      expect(page).to have_content('CO')
      expect(page).to have_content('20202')
      expect(page).to have_content('I would like this dog for these reasons.')
      expect(page).to have_content('In Progress')
      expect(page).to have_content('Fluffy')
    end
  end
end
