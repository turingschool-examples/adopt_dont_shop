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
    @application_2 = @pet_1.applications.create(
      name: "Brady",
      street_address:  "333 Fake St",
      city: "Denver",
      state: "CO",
      zip: "80555",
      description: "I love pets",
      status: "Pending"
    )
    ApplicationPet.create!(pet: @pet_2, application: @application_1)
    ApplicationPet.create!(pet: @pet_2, application: @application_2)
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

  #User Story 13
  describe "When i visit admin/applications/:id" do
    it "Displays 'Reject' button next to each added pet" do
      visit "/admin/applications/#{@application_1.id}" 
      expect(page).to have_content("Pets:\nBare-y Manilow\nMr. Pirate")
      expect(page).to have_selector(:button, "Reject Bare-y Manilow")
      expect(page).to have_selector(:button, "Reject Mr. Pirate")
    end
    it "Clicking it redirects me to same page" do
      visit "/admin/applications/#{@application_1.id}" 
      click_button("Reject Bare-y Manilow")
      expect(page).to have_current_path("/admin/applications/#{@application_1.id}")
    end
    it "Indicates that pet has been approved and button is gone" do
      visit "/admin/applications/#{@application_1.id}" 
      click_button("Reject Bare-y Manilow")
      expect(page).to have_current_path("/admin/applications/#{@application_1.id}")

      expect(page).to have_selector(:button, "Approve Mr. Pirate")
      expect(page).to have_selector(:button, "Reject Mr. Pirate")

      expect(page).to_not have_selector(:button, "Approve Bare-y Manilow")
      expect(page).to_not have_selector(:button, "Reject Bare-y Manilow")
      expect(page).to have_content("Pets: Bare-y Manilow:Approved false\nMr. Pirate")
    end
  end
  #User Story 14
  describe "When I visit admin/applications/:id" do
    it "Approving/rejecting a pet does not affect the same pet on other applications" do
      visit "/admin/applications/#{@application_1.id}"
      expect(page).to have_selector(:button, "Approve Mr. Pirate")
      expect(page).to have_selector(:button, "Reject Mr. Pirate")
      expect(page).to have_selector(:button, "Approve Bare-y Manilow")
      expect(page).to have_selector(:button, "Reject Bare-y Manilow")

      click_button("Reject Mr. Pirate")
      click_button("Approve Bare-y Manilow")

      visit "/admin/applications/#{@application_2.id}"
      expect(page).to have_selector(:button, "Approve Mr. Pirate")
      expect(page).to have_selector(:button, "Reject Mr. Pirate")
      expect(page).to have_selector(:button, "Approve Bare-y Manilow")
      expect(page).to have_selector(:button, "Reject Bare-y Manilow")
    end
  end
  #User Story 15
  describe "When I visit admin/applications/:id" do
    it "Approving all pets takes me back to the showpage and changes status to 'Approved'" do

      visit "/admin/applications/#{@application_1.id}"
      expect(page).to have_content("App Status: Pending")
      click_button("Approve Bare-y Manilow")
      click_button("Approve Mr. Pirate")

      expect(page).to have_current_path("/admin/applications/#{@application_1.id}")
      expect(page).to have_content("App Status: Approved!")
    end
  end
end