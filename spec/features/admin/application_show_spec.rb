require 'rails_helper'

RSpec.describe 'admin application show' do
  let(:shelter) { Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9) }
  let(:application) { Application.create!(
                                    name: "Nate Brown",
                          street_address: "2000 35th Avenue",
                                    city: "Denver",
                                   state: "CO",
                                     zip: "90210",
                                  status: "Pending",
                              description: "Big ol' backyard to run around in"

                                         )}
     describe 'the admin application show page' do
       it "has the applicant/'s attributes" do
         visit "admin/applications/#{application.id}"

         expect(page).to have_content(application.name)
         expect(page).to have_content(application.full_address)
         expect(page).to have_content(application.description)
         expect(page).to have_content(application.status)
       end

       it "has working button for approving pets" do
         shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
         pet_1 = shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
         pet_2 = shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
         application.pets << pet_1
         application.pets << pet_2

         visit "admin/applications/#{application.id}"

         click_button 'Approve Mr. Pirate'

         expect(page).to have_content("Status: Pending")

         click_button 'Approve Clawdia'

         expect(page).to have_content("Status: Approved")
       end
     end
 end
