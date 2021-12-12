require 'rails_helper'

describe 'Admin Application Show' do
  before do
    @shelter = Shelter.create(name: 'Rescue Shelter', city: 'Denver, CO', foster_program: false, rank: 3)
    @pet1 = Pet.create(adoptable: true, age: 4, breed: 'doberman', name: 'Carson', shelter_id: @shelter.id)
    @pet2 = Pet.create(adoptable: true, age: 2, breed: 'heeler', name: 'Larry', shelter_id: @shelter.id)
    @application = Application.create(name: 'Devin', address: '123 Easy St', state: "Colorado", city: "Denver", zip: "80911", description: "I like degs", status: "Pending")
    PetApplication.create(pet_id: @pet1.id, application_id: @application.id)
    PetApplication.create(pet_id: @pet2.id, application_id: @application.id)
    visit "/admin/applications/#{@application.id}"
  end

  describe 'display' do
    describe 'a button to approve the application for that specific pet' do
      it 'when i click that button, button goes away, and now i see an indication the pet is approved' do
        within('#Approve_pets') do
          click_button("Approve Application for #{@pet1.name}")

          expect(page).to have_content("Carson - APPROVED")
          expect(page).to have_content("Pending")
        end
      end
    end
  end
end