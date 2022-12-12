require 'rails_helper'

RSpec.describe "ADMIN Application Show" do
  # let!(:shelter_1){Shelter.create!(:shelter)}
  # let!(:pet_1){FactoryBot.create!(:pet)}
  # let!(:application_1){FactoryBot.create!(:application)}
  # let!(:application_pet){FactoryBot.create!(:application_pet)}

  describe "Story 12 - Approving a Pet for Adoption" do
    it "has a button next to EACH pet to approve adoption on application" do
      @shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      @pet_1 = @shelter.pets.create!(name: "Ziggy", age: 6, breed: 'Westy', adoptable: true, shelter_id: @shelter.id)
      # let!(:pet_2) { Pet.create!(name: 'Scoobyroo', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)}
      @application = Application.create!(name: 'Joe', street_address: "123 street lane", city: "denver", state: "co", zip_code: "12345",  description: "I like dogs", status: "Pending" )
      ApplicationPet.create!(application_id: @application.id, pet_id: @pet_1.id)
      
      # When I visit an admin application show page ('/admin/applications/:id')
      visit "/admin/applications/#{@application.id}"
      # For every pet that the application is for, I see a button to approve the application for that specific pet
      expect(page).to have_content("#{@pet_1.name}")
      expect(page).to have_button("Approve")
      # When I click that button
      click_button("Approve")
      # Then I'm taken back to the admin application show page
      expect(current_path).to eq "/admin/applications/#{@application.id}"
      # And next to the pet that I approved, I do not see a button to approve this pet
      expect(page).to_not have_button("Approve")
      # And instead I see an indicator next to the pet that they have been approved
      expect(page).to have_content("Pet Approved")
      
    end
  end
  
  describe "Story 13 - Rejecting a Pet for Adoption" do
    it "has a button to reject a pet from an application" do
      @shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      @pet_1 = @shelter.pets.create!(name: "Ziggy", age: 6, breed: 'Westy', adoptable: true, shelter_id: @shelter.id)
      @pet_2 = @shelter.pets.create!(name: "Mizzy", age: 3, breed: 'Aussie', adoptable: true, shelter_id: @shelter.id)
      @application = Application.create!(name: 'Joe', street_address: "123 street lane", city: "denver", state: "co", zip_code: "12345",  description: "I like dogs", status: "Pending" )
      ApplicationPet.create!(application_id: @application.id, pet_id: @pet_1.id)
      ApplicationPet.create!(application_id: @application.id, pet_id: @pet_2.id)
      
      # When I visit an admin application show page ('/admin/applications/:id')
      visit "/admin/applications/#{@application.id}"
      # For every pet that the application is for, I see a button to reject the application for that specific pet
      expect(page).to have_button("Reject")
      # When I click that button
      click_button("Reject")
      # Then I'm taken back to the admin application show page
      expect(current_path).to eq "/admin/applications/#{@application.id}"
      # And next to the pet that I rejected, I do not see a button to approve or reject this pet
      expect(page).to_not have_button("Approve")
      expect(page).to_not have_button("Reject")
      # And instead I see an indicator next to the pet that they have been rejected
      expect(page).to have_content("Pet Rejected")
    end
  end
end