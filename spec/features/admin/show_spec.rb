# As a visitor
# When I visit an admin application show page ('/admin/applications/:id')
# For every pet that the application is for, I see a button to approve the application for that specific pet
# When I click that button
# Then I'm taken back to the admin application show page
# And next to the pet that I approved, I do not see a button to approve this pet
#And instead I see an indicator next to the pet that they have been approved
#
# As a visitor
# When I visit an admin application show page ('/admin/applications/:id')
# For every pet that the application is for, I see a button to reject the application for that specific pet
# When I click that button
# Then I'm taken back to the admin application show page
# And next to the pet that I rejected, I do not see a button to approve or reject this pet
# And instead I see an indicator next to the pet that they have been rejected
#
# As a visitor
# When there are two applications in the system for the same pet
# When I visit the admin application show page for one of the applications
# And I approve or reject the pet for that application
# When I visit the other application's admin show page
# Then I do not see that the pet has been accepted or rejected for that application
# And instead I see buttons to approve or reject the pet for this specific application

require 'rails_helper'

RSpec.describe "Admin applications Show" do
  before :each do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)

    @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @pet_2 = @shelter_2.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @pet_3 = @shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)

    @application_1 = Application.create!(name: "Carol Crikey", street_address: "2022 S Fake Street", city: "Birmingham",
      state: "AL", zip_code: "54738", description: 'empty', status: "Pending")

    @application_2 = Application.create!(name: "John H", street_address: "123 Anywhere Ave", city: "Denver",
      state: "CO", zip_code: "80204", description: 'I would be good at it', status: "Pending")

    #set up the join table ids
    @applicaion_pets_1 = @pet_1.applications << @application_1
    @applicaion_pets_2 = @pet_2.applications << @application_1
    @applicaion_pets_3 = @pet_1.applications << @application_2
    @applicaion_pets_4 = @pet_2.applications << @application_2

  end
  describe "display" do
    it "shows an admin application with pets to approve" do

      visit "/admin/applications/#{@application_1.id}"
      expect(current_path).to eq ("/admin/applications/#{@application_1.id}")
      expect(page).to have_content(@pet_1.name)
      expect(page).to have_content(@pet_2.name)
      expect(page).to have_button("Approve")

      click_button("Approve", match: :first)
      expect(current_path).to eq ("/admin/applications/#{@application_1.id}/")
      expect(page).to have_content("This application has been approved!")
    end

    it "shows an admin application with pets to reject" do

      visit "/admin/applications/#{@application_1.id}"
      expect(current_path).to eq ("/admin/applications/#{@application_1.id}")
      expect(page).to have_content(@pet_1.name)
      expect(page).to have_content(@pet_2.name)
      click_button("Reject", match: :first)
      expect(page).to have_content("This application has been rejected!")

    end

    it "displays a button to approve or reject application for a pet if there are two applications for the same pet" do

      visit "/admin/applications/#{@application_1.id}"
      expect(page).to have_content(@pet_1.name)
      expect(page).to have_content(@pet_2.name)
      expect(page).to have_button("Reject")
      click_button("Reject", match: :first)
#      save_and_open_page

      expect(current_path).to eq("/admin/applications/#{@application_1.id}/")
      expect(page).to have_content("This application has been rejected!")

      visit "/admin/applications/#{@application_2.id}"
#      save_and_open_page
      expect(page).to have_content(@pet_1.name)
      expect(page).to have_button("Approve")
      expect(page).to have_button("Reject")

    end
  end
end
