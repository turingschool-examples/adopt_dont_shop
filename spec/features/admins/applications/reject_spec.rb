require 'rails_helper'

RSpec.describe 'rejecting application' do 
  describe 'when I visit /admin/applications/:id' do 
    it 'shows a button to approve each pet' do 
      shelter = Shelter.create!(name: "Brightside", city: "Salem", rank: 2, foster_program: true)
      pet_1 = shelter.pets.create!(name: "Bobby", age: 2, breed: 'Bulldog', adoptable: true)
      pet_2 = shelter.pets.create!(name: "Sammy", age: 5, breed: 'lab', adoptable: true)
      application_1 = pet_1.applications.create!(name: 'Billy Bob', street_address: "54984 Bulldog Rd", city: "Salem", state: "OR", zipcode: "97301", description: "Billy Bob wants a buddy", status: "Pending")
      ApplicationPet.create!(pet: pet_2, application: application_1)

      visit "/admin/applications/#{application_1.id}"

      click_on("Reject #{pet_1.name}")

      expect(current_path).to eq("/admin/applications/#{application_1.id}")

      within "#Pets" do
        expect(page).to have_content("Rejected")
        expect(page).to_not have_button("Reject #{pet_1.name}")
        expect(page).to_not have_button("Approve #{pet_1.name}")
      end
    end 

    it 'will not effect another application if approved or rejected' do 
      shelter = Shelter.create!(name: "Brightside", city: "Salem", rank: 2, foster_program: true)
      pet_1 = shelter.pets.create!(name: "Bobby", age: 2, breed: 'Bulldog', adoptable: true)
      pet_2 = shelter.pets.create!(name: "Sammy", age: 5, breed: 'lab', adoptable: true)
      application_1 = pet_1.applications.create!(name: 'Billy Bob', street_address: "54984 Bulldog Rd", city: "Salem", state: "OR", zipcode: "97301", description: "Billy Bob wants a buddy", status: "Pending")
      ApplicationPet.create!(pet: pet_2, application: application_1)
      
      application_2 = pet_1.applications.create!(name: 'Billy Bob', street_address: "54984 Bulldog Rd", city: "Salem", state: "OR", zipcode: "97301", description: "Billy Bob wants a buddy", status: "Pending")

      visit "/admin/applications/#{application_1.id}"
     
      click_on("Reject #{pet_1.name}")

      visit "/admin/applications/#{application_2.id}"
      
      expect(page).to_not have_content("Rejected")
    end 
  end 
end 