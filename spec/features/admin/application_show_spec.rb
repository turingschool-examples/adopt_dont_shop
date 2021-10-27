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
  let(:application_2) { Application.create!(
                                    name: "Jon Brown",
                          street_address: "200 37th Avenue",
                                    city: "NYC",
                                   state: "NY",
                                     zip: "90210",
                                  status: "Pending",
                              description: "Lots of scraps at mah house"
                                         )}
     describe 'the admin application show page' do
       it "has the applicant/'s attributes" do
         visit "admin/applications/#{application.id}"

         expect(page).to have_content(application.name)
         expect(page).to have_content(application.full_address)
         expect(page).to have_content(application.description)
         expect(page).to have_content(application.status)
       end

       it "has working approve button for approving pets" do
         shelter_1 = Shelter.create(name: 'Dank shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
         pet_1 = shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
         pet_2 = shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)


         ApplicationPet.create!(application: application, pet: pet_1)
         ApplicationPet.create!(application: application, pet: pet_2)

         visit "admin/applications/#{application.id}"

         click_button 'Approve Mr. Pirate'

         expect(page).to have_content("Status: Pending")
         has_no_button?('Approve Mr. Pirate')

         click_button 'Approve Clawdia'

         expect(page).to have_content("Status: Approved")
         has_no_button?('Approve Clawdia')
       end

       it "has working reject button for rejecting pets" do
         shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
         pet_1 = shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
         pet_2 = shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
         application.pets << pet_1
         application.pets << pet_2

         visit "admin/applications/#{application.id}"

         click_button 'Reject Mr. Pirate'
         has_no_button?('Reject Mr. Pirate')
         expect(page).to have_content("Status: Rejected")
       end

       it "approved applications do not affect other applications" do
         shelter_1 = Shelter.create(name: 'Nice shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
         pet_1 = shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
         pet_2 = shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
         application.pets << pet_1
         application.pets << pet_2

         application_2.pets << pet_1
         application_2.pets << pet_2

         visit "/admin/applications/#{application.id}"

         click_button 'Reject Mr. Pirate'
         has_no_button?('Reject Mr. Pirate')
         expect(page).to have_content("Status: Rejected")

         visit "/admin/applications/#{application_2.id}"

         has_button?('Reject Mr. Pirate')
         expect(page).to have_content("Status: Pending")
         expect(page).to have_content("State: Pending")
       end

       it 'ensures pet can only have one approval at a time' do
         shelter_1 = Shelter.create(name: 'Dope shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
         pet_1 = shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
         pet_2 = shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
         application.pets << pet_1
         application.pets << pet_2

         application_2.pets << pet_1
         application_2.pets << pet_2

         visit "/admin/applications/#{application.id}"

         click_button 'Approve Mr. Pirate'

         visit "/admin/applications/#{application_2.id}"

         expect(page).to_not have_button("Approve Mr. Pirate")
         expect(page).to have_content("#{pet_1.name} has been approved for adoption on someone else's application")
       end
     end
 end
