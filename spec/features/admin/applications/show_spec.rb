require 'rails_helper'

RSpec.describe 'Admin Applications Show' do
  before(:each) do
    shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @pet_1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
    @pet_2 = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)
    @pet_3 = Pet.create!(adoptable: true, age: 7, breed: 'mut', name: 'Frog', shelter_id: shelter.id)
    @app_1 = Application.create!(first: "Joe", last: "Hilby", street: "1234 N A St", city: "Any Town", state: "AnyState", zip: "12345", description: "So cute!", status: "Pending")
    @app_2 = Application.create!(first: "Kevin", last: "Smith", street: "Street", city: "Any Town", state: "AnyState", zip: "12345", description: "Much dog!", status: "In Progress")
    ApplicationPet.create!(pet: @pet_1, application: @app_1)
    ApplicationPet.create!(pet: @pet_2, application: @app_1)
  end
  describe 'When I visit /admin/applications/:id' do
    describe 'Then I see' do
      it 'the select application with its attributes' do
        visit "/admin/applications/#{@app_1.id}"

        expect(page).to have_content("Joe")
        expect(page).to have_content("Hilby")
        expect(page).to have_content("1234 N A St")
        expect(page).to have_content("Any Town")
        expect(page).to have_content("AnyState")
        expect(page).to have_content("12345")
        expect(page).to have_content("So cute!")
        expect(page).to have_content("Pending")
        expect(page).to have_content(@pet_1.name)
        expect(page).to have_content(@pet_2.name)
      end
      it 'a button to approve each individual pet in the application' do
        visit "/admin/applications/#{@app_1.id}"
        save_and_open_page
        expect(page).to have_content("Approve")
      end
    end
    describe 'When I click button "Approve" then I am' do
      it 'taken back to /admin/applications/:id'
      it 'there is no button next to the approved pet'
      it 'there is an indicator next to the pet that they have been approved'
    end
  end

end