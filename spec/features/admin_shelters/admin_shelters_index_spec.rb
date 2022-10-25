require 'rails_helper'

RSpec.describe 'admin shelters index' do 
  describe 'user story 11' do 
    it ' will show a section for shelters with pending applications and i see the name of every shelter with pending apps' do 
      shelter5 = Shelter.create!(name: "Pet Rock Shelter", city: "Boulder", rank: 1, foster_program: true)
      shelter6 = Shelter.create!(name: "ASPCA", city: "Las Vegas", rank: 3, foster_program: true)
      pet1 = shelter5.pets.create!(name: "Taco", breed: "Dachshund", age: 4, adoptable: true)
      pet2 = shelter6.pets.create!(name: "Sergio", breed: "Mutt", age: 16, adoptable: true)
      app1 = Applicant.create!(name: "Ashley Turner", street_address: "123 Oregon Trail Way", city: "Portland", state: "OR", zip_code: "54321", description: "Pet sitting and want to have my own", status: "Pending")
      app2 = Applicant.create!(name: "Kristen Nestler", street_address: "4786 Yankee Way", city: "New York", state: "NY", zip_code: "02134", description: "Being single is lonely.", status: "In Progress")
      pet_app1 = PetApplicant.create!(pet_id: pet1.id, applicant_id: app1.id)
      pet_app2 = PetApplicant.create!(pet_id: pet2.id, applicant_id: app2.id)

      visit "/admin/shelters"

      expect(page).to have_content(shelter5.name)
      expect(page).to_not have_content(shelter6.name)
    end
  end
end