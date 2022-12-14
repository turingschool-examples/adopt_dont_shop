require 'rails_helper'

RSpec.describe "ADMIN Application Show" do

  describe "Story 12 - Approving a Pet for Adoption" do
    it "has a button next to EACH pet to approve adoption on application" do
      @shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      @pet_1 = @shelter.pets.create!(name: "Ziggy", age: 6, breed: 'Westy', adoptable: true, shelter_id: @shelter.id)
      @application = Application.create!(name: 'Joe', street_address: "123 street lane", city: "denver", state: "co", zip_code: "12345",  description: "I like dogs", status: "Pending" )
      ApplicationPet.create!(application_id: @application.id, pet_id: @pet_1.id)
      
      visit "/admin/applications/#{@application.id}"

      expect(page).to have_content("#{@pet_1.name}")
      expect(page).to have_button("Approve")

      click_button("Approve")

      expect(current_path).to eq "/admin/applications/#{@application.id}"
      expect(page).to_not have_button("Approve")
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
      
      visit "/admin/applications/#{@application.id}"
      
      expect(page).to have_button("Reject", match: :first)
      
      click_button("Reject", match: :first)

      expect(current_path).to eq "/admin/applications/#{@application.id}"
      click_button("Approve", match: :first)

      expect(page).to_not have_button("Approve")
      expect(page).to_not have_button("Reject")
      expect(page).to have_content("Pet Rejected")
    end
  end

  describe "story 14" do
    it "won't effect other application if a pet is approved or denied" do
      @shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      @pet_1 = @shelter.pets.create!(name: "Ziggy", age: 6, breed: 'Westy', adoptable: true, shelter_id: @shelter.id)
      @pet_2 = @shelter.pets.create!(name: "Mizzy", age: 3, breed: 'Aussie', adoptable: true, shelter_id: @shelter.id)
      @application_1 = Application.create!(name: 'Joe', street_address: "123 street lane", city: "denver", state: "co", zip_code: "12345",  description: "I like dogs", status: "Pending" )
      @application_2 = Application.create!(name: 'Joe', street_address: "123 street lane", city: "denver", state: "co", zip_code: "12345",  description: "I like dogs", status: "Pending" )
      ApplicationPet.create!(application_id: @application_1.id, pet_id: @pet_1.id)
      ApplicationPet.create!(application_id: @application_2.id, pet_id: @pet_1.id)
      visit "/admin/applications/#{@application_1.id}"

      expect(page).to have_button("Reject", match: :first)
      click_button("Reject", match: :first)

      expect(page).to_not have_button("Approve")
      expect(page).to_not have_button("Reject")
      expect(page).to have_content("Pet Rejected")

      visit "/admin/applications/#{@application_2.id}"

      expect(page).to have_button("Reject", match: :first)
      expect(page).to have_button("Approve", match: :first)
    end

  end

  describe 'story_15' do
    it 'goes back to the admin application show page after all pets are approved' do
    #   As a visitor
    #   When I visit an admin application show page
    #   And I approve all pets for an application
    #   Then I am taken back to the admin application show page
    #   And I see the application's status has changed to "Approved"
      @shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      @pet_1 = @shelter.pets.create!(name: "Ziggy", age: 6, breed: 'Westy', adoptable: true, shelter_id: @shelter.id)
      @pet_2 = @shelter.pets.create!(name: "Mizzy", age: 3, breed: 'Aussie', adoptable: true, shelter_id: @shelter.id)
      @application_1 = Application.create!(name: 'Joe', street_address: "123 street lane", city: "denver", state: "co", zip_code: "12345",  description: "I like dogs", status: "Pending" )
      @application_2 = Application.create!(name: 'Joe', street_address: "123 street lane", city: "denver", state: "co", zip_code: "12345",  description: "I like dogs", status: "Pending" )
      @ap_1 = ApplicationPet.create!(application_id: @application_1.id, pet_id: @pet_1.id)
      @ap_2 = ApplicationPet.create!(application_id: @application_1.id, pet_id: @pet_2.id)

      visit "/admin/applications/#{@application_1.id}"

      within("##{@ap_1.id}") do
        click_button("Approve")
      end
      within("##{@ap_2.id}") do
        click_button("Approve")
      end
      
      expect(current_path).to eq("/admin/applications/#{@application_1.id}")
      
      expect(page).to have_content("Status: Approved")
      expect(@application_1.reload.status).to eq("Approved")
    end
    
    describe 'story_16' do
      # One or More Pets Rejected on an Application
      # As a visitor
      # When I visit an admin application show page
      # And I reject one or more pets for the application
      # And I approve all other pets on the application
      # Then I am taken back to the admin application show page
      # And I see the application's status has changed to "Rejected"
      it "will reject applications if atleast one pet is denied" do
        @shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
        @pet_1 = @shelter.pets.create!(name: "Ziggy", age: 6, breed: 'Westy', adoptable: true, shelter_id: @shelter.id)
        @pet_2 = @shelter.pets.create!(name: "Mizzy", age: 3, breed: 'Aussie', adoptable: true, shelter_id: @shelter.id)
      @application_1 = Application.create!(name: 'Joe', street_address: "123 street lane", city: "denver", state: "co", zip_code: "12345",  description: "I like dogs", status: "Pending" )
      @application_2 = Application.create!(name: 'Joe', street_address: "123 street lane", city: "denver", state: "co", zip_code: "12345",  description: "I like dogs", status: "Pending" )
      @ap_1 = ApplicationPet.create!(application_id: @application_1.id, pet_id: @pet_1.id)
      @ap_2 = ApplicationPet.create!(application_id: @application_1.id, pet_id: @pet_2.id)
      
      visit "/admin/applications/#{@application_1.id}"
      # save_and_open_page
      within("##{@ap_1.id}") do
        click_button("Approve")
      end
      within("##{@ap_2.id}") do
        click_button("Reject")
      end
      # save_and_open_page
      expect(current_path).to eq("/admin/applications/#{@application_1.id}")
      
      
      expect(page).to have_content("Status: Denied")
      expect(@application_1.reload.status).to eq("Denied")
    end
    end


  end

end