require 'rails_helper'

#12. Approving a Pet for Adoption
# As a visitor
# When I visit an admin application show page ('/admin/applications/:id')
# For every pet that the application is for, I see a button to approve the application for that specific pet
# When I click that button
# Then I'm taken back to the admin application show page
# And next to the pet that I approved, I do not see a button to approve this pet
# And instead I see an indicator next to the pet that they have been approved
RSpec.describe "AdminShow" do 
    before(:each) do 
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    @pet1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @pet2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @pet3 = @shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
    @applicant1 = Applicant.create!(name: "Judge Judy", street_address: "666 Elm St", city: "New Jersey", state: "NJ", zip: "8675309", status: 'Pending')
    @applicant2 = Applicant.create!(name: "Pink Flyod", street_address: "5150 High St", city: "Crater Lake", state: "None", zip: "12345", status: 'Pending')
    end
     describe 'admin approving applicant for pet' do 
      it 'has a button to approve the applicant for the pet' do

        @applicant1.pets << @pet1 << @pet2
        
        visit "/admin/applicants/#{@applicant1.id}"
        
        expect(page).to have_button("Approve #{@pet1.name}")
        expect(page).to have_button("Approve #{@pet2.name}")
      end 
     
      it 'after clicking approve i am taken back to updated show page' do
        @applicant1.pets << @pet1 << @pet2
      
        visit "/admin/applicants/#{@applicant1.id}"
        click_button "Approve #{@pet1.name}"
        save_and_open_page
        expect(current_path).to eq("/admin/applicants/#{@applicant1.id}")
        expect(page).to have_content("#{@pet1.name} Approved")
        expect(page).to_not have_button("Approve #{@pet1.name}")
      end
    end

# 13. Rejecting a Pet for Adoption
# As a visitor
# When I visit an admin application show page ('/admin/applications/:id')
# For every pet that the application is for, I see a button to reject the application for that specific pet
# When I click that button
# Then I'm taken back to the admin application show page
# And next to the pet that I rejected, I do not see a button to approve or reject this pet
# And instead I see an indicator next to the pet that they have been rejected
# end