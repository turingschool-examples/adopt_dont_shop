require 'rails_helper' 

RSpec.describe 'Admin Applicant: Approving a pet for adoption' do 
  before :each do 
      @shelter5 = Shelter.create!(name: "Pet Rock Shelter", city: "Boulder", rank: 1, foster_program: true)
      @shelter6 = Shelter.create!(name: "ASPCA", city: "Las Vegas", rank: 3, foster_program: true)
      @pet1 = shelter5.pets.create!(name: "Taco", breed: "Dachshund", age: 4, adoptable: true)
      @pet2 = shelter6.pets.create!(name: "Sergio", breed: "Mutt", age: 16, adoptable: true)
      @app1 = Applicant.create!(name: "Ashley Turner", street_address: "123 Oregon Trail Way", city: "Portland", state: "OR", zip_code: "54321", description: "Pet sitting and want to have my own", status: "Pending")
      @app2 = Applicant.create!(name: "Kristen Nestler", street_address: "4786 Yankee Way", city: "New York", state: "NY", zip_code: "02134", description: "Being single is lonely.", status: "In Progress")
      @pet_app1 = PetApplicant.create!(pet_id: @pet1.id, applicant_id: @app1.id)
      @pet_app2 = PetApplicant.create!(pet_id: @pet2.id, applicant_id: @app2.id)
  end
  describe 'US-12: Button to approve applicant for a specific pet ' do 
    it 'When i visit admin appl show page, I see a button to approve a specific pet. When I click that button
        Im taken back to the admin appl show page. Next to the pet I approved, I do not see a button to approve the pet.
          Instead I see an indicator next to the pet that they have been approved' do 

          visit "/admin/applicants/#{@app1.id}"

          expect(page).to have_content("#{@app1.name}")
          expect(page).to have_content("#{@pet1.name}")
          expect(page).to have_button("Approve")
          expect(page).to_not have_content("#{@pet2.name}")

          click_button("Approve")

          expect(current_path).to eq("/admin/applicants/#{@app1.id}")
          expect(page).to_not have_button("Approve")
          expect(page).to have_content("Approved")

    end
  end
end