require 'rails_helper'

RSpec.describe 'Application Show' do
  before :each do
    @shelter_1 = Shelter.create!(foster_program: true, name: "ABC Shelter", city: "Nashville", rank: 1)
    @pet_1 = @shelter_1.pets.create!(adoptable: true, age: 3, breed: "Goldendoodle", name: "Daisy")
    @pet_2 = @shelter_1.pets.create(adoptable: false, age: 7, breed: "Terrier", name: "Chewie")
    @application_1 = Application.create!(name: 'John', address: '123 Main Street', city: 'Nashville', state: 'TN', zip: 37067, description: "I want a nice dog.", status: "In Progress")
    @pet_application_1 = PetApplication.create(pet_id: @pet_1.id, application_id: @application_1.id)
end

  describe 'attributes' do
    it 'shows the applicant and its attributes' do
      visit "/applications/#{@application_1.id}"

      expect(page).to have_content(@application_1.name)
      expect(page).to have_content(@application_1.address)
      expect(page).to have_content(@application_1.city)
      expect(page).to have_content(@application_1.state)
      expect(page).to have_content(@application_1.zip)
      expect(page).to have_content(@application_1.description)
      expect(page).to have_content(@application_1.status)
    end
  end
end
