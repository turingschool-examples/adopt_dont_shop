require 'rails_helper'

RSpec.describe 'admin/applications/:id' do
  before(:each) do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @pet_1 = @shelter_1.pets.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Bare-y Manilow')
    @pet_2 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @application_1 = @pet_1.applications.create(
      name: "Billy Mays",
      street_address:  "123 Main St",
      city: "Aurora",
      state: "CO",
      zip: "80012",
      description: "I like pets",
      status: "Pending"
  )
    ApplicationPet.create!(pet: @pet_2, application: @application_1)
  end

  #User Story 12
  describe "When i visit admin/applications/:id" do
    it "Displays 'Approve' button next to each added pet" do
      visit "/admin/applications/#{@application_1.id}" 
      expect(page).to have_content("Pets:\nBare-y Manilow\nMr. Pirate")
      expect(page).to have_selector(:button, "Approve Bare-y Manilow")
      expect(page).to have_selector(:button, "Approve Mr. Pirate")
    end
    
    it "Clicking it redirects me to same page" do
      visit "/admin/applications/#{@application_1.id}" 
      expect(page).to have_selector(:button, "Approve Bare-y Manilow")
      expect(page).to have_selector(:button, "Approve Mr. Pirate")
      click_button("Approve Bare-y Manilow")
      expect(page).to have_current_path("/admin/applications/#{@application_1.id}")
    end
    it "Indicates that pet has been approved and button is gone" do
      visit "/admin/applications/#{@application_1.id}" 
      click_button("Approve Bare-y Manilow")
      expect(page).to have_current_path("/admin/applications/#{@application_1.id}")

      expect(page).to have_selector(:button, "Approve Mr. Pirate")
      expect(page).to_not have_selector(:button, "Approve Bare-y Manilow")
      expect(page).to have_content("Pets: Bare-y Manilow:Approved true\nMr. Pirate")
    end
  end
end