require 'rails_helper'

RSpec.describe 'admin application show page' do
  before :each do
    @application_1 = Application.create!(applicant_name: "Mike Sloan", street_address: "134 Willow Lane", city: "Boulder", state: "CO", zip_code: "80034", application_status: "Pending")

    @application_2 = Application.create!(applicant_name: "Ben Spiegel", street_address: "6625 Main, Apt. 9", city: "Denver", state: "CO", zip_code: "80026", application_status: "Pending")

    @application_3 = Application.create!(applicant_name: "Ben Spiegel", street_address: "6625 Main, Apt. 9", city: "Denver", state: "CO", zip_code: "80026", application_status: "In Progress")

    @shelter_1 = Shelter.create!(foster_program: 'true', name: "Shelter 1", city: "Denver", rank: "5")

    @pet_1 = @application_1.pets.create!(adoptable: "true", age: "3", breed: "Terrier", name: "Sparky", shelter_id: "#{@shelter_1.id}")
    @pet_2 = @application_1.pets.create!(adoptable: "true", age: "1", breed: "Black Lab", name: "Spot", shelter_id: "#{@shelter_1.id}")

    @pet_3 = @application_2.pets.create!(adoptable: "true", age: "6", breed: "Yellow Lab", name: "Bow Wow", shelter_id: "#{@shelter_1.id}")
    @pet_4 = @application_2.pets.create!(adoptable: "true", age: "11", breed: "Bulldog", name: "Spot", shelter_id: "#{@shelter_1.id}")

    @pet_5 = @application_3.pets.create!(adoptable: "true", age: "11", breed: "Bulldog", name: "Sally", shelter_id: "#{@shelter_1.id}")
  end

  describe 'visit admin application show page' do
    it 'has content' do
      visit "admin/applications/#{@application_1.id}"

      expect(page).to have_content(@application_1.applicant_name)
      expect(page).to have_content(@application_1.street_address)
      expect(page).to have_content(@application_1.city)
      expect(page).to have_content(@application_1.state)
      expect(page).to have_content(@application_1.zip_code)
      expect(page).to have_content("Applicant Description:")
      expect(page).to have_content(@application_1.application_status)
      expect(page).to have_content(@pet_1.name)
      expect(page).to have_link("#{@pet_1.name}", href: "/pets/#{@pet_1.id}")
      expect(page).to have_content(@pet_2.name)
      expect(page).to have_link("#{@pet_2.name}", href: "/pets/#{@pet_2.id}")
    end

    it 'has approve button for each pet' do
      visit "admin/applications/#{@application_1.id}"

      within("#pet#{@pet_1.id}") do
        expect(page).to have_button("Approve Adoption")
        expect(page).to have_button("Deny Adoption")
      end

      within("#pet#{@pet_2.id}") do
        expect(page).to have_button("Approve Adoption")
        expect(page).to have_button("Deny Adoption")
      end
    end

    it 'changes status of pet to approved and removes button' do
      visit "/admin/applications/#{@application_1.id}"

      within("#pet#{@pet_1.id}") do
        click_button "Approve Adoption"
        expect(current_path).to eq("/admin/applications/#{@application_1.id}")
        expect(page).to have_content("Application: Approved")
        expect(page).to_not have_button("Approve Adoption")
      end

      within("#pet#{@pet_2.id}") do
        expect(page).to have_button("Approve Adoption")
        click_button "Approve Adoption"
        expect(current_path).to eq("/admin/applications/#{@application_1.id}")
        expect(page).to have_content("Application: Approved")
        expect(page).to_not have_button("Approve Adoption")
      end
    end

    it 'changes status of pet to denieded and removes button' do
      visit "/admin/applications/#{@application_1.id}"

      within("#pet#{@pet_1.id}") do
        click_button "Deny Adoption"
        expect(current_path).to eq("/admin/applications/#{@application_1.id}")
        expect(page).to have_content("Application: Denied")
        expect(page).to_not have_button("Approve Adoption")
        expect(page).to_not have_button("Deny Adoption")
      end

      within("#pet#{@pet_2.id}") do
        expect(page).to have_button("Approve Adoption")
        click_button "Deny Adoption"
        expect(current_path).to eq("/admin/applications/#{@application_1.id}")
        expect(page).to have_content("Application: Denied")
        expect(page).to_not have_button("Approve Adoption")
        expect(page).to_not have_button("Deny Adoption")
      end
    end

    it 'does not change pet application status on other applications' do
      test_pet_1 = Pet.create!(adoptable: "true", age: "3", breed: "Terrier", name: "Sparky", shelter_id: "#{@shelter_1.id}")

      test_app_1 = test_pet_1.applications.create(applicant_name: "Mike Sloan", street_address: "134 Willow Lane", city: "Boulder", state: "CO", zip_code: "80034", application_status: "Pending")
      test_app_2 = test_pet_1.applications.create(applicant_name: "Ben Spiegel", street_address: "6625 Main, Apt. 9", city: "Denver", state: "CO", zip_code: "80026", application_status: "Pending")

      visit "/admin/applications/#{test_app_1.id}"
      save_and_open_page
      within("#pet#{test_pet_1.id}") do
        expect(page).to have_button("Approve Adoption")
        expect(page).to have_button("Deny Adoption")
      end

      visit "/admin/applications/#{test_app_2.id}"

      within("#pet#{test_pet_1.id}") do
        expect(page).to have_button("Approve Adoption")
        expect(page).to have_button("Deny Adoption")

        click_button "Deny Adoption"

        expect(current_path).to eq("/admin/applications/#{test_app_2.id}")
        expect(page).to have_content("Application: Denied")
        expect(page).to_not have_button("Approve Adoption")
        expect(page).to_not have_button("Deny Adoption")
      end

      visit "/admin/applications/#{test_app_1.id}"

      within("#pet#{test_pet_1.id}") do
        expect(page).to have_button("Approve Adoption")
        expect(page).to have_button("Deny Adoption")

        click_button "Approve Adoption"
        save_and_open_page
        expect(page).to have_content("Application: Approved")
        expect(page).to_not have_button("Approve Adoption")
        expect(page).to_not have_button("Deny Adoption")
      end

      visit "/admin/applications/#{test_app_2.id}"

      within("#pet#{test_pet_1.id}") do
        expect(page).to have_content("Application: Denied")
        expect(page).to_not have_button("Approve Adoption")
        expect(page).to_not have_button("Deny Adoption")
      end
    end
  end
end
# When I visit an admin application show page ('/admin/applications/:id')
# For every pet that the application is for, I see a button to approve the application for that specific pet
# When I click that button
# Then I'm taken back to the admin application show page
# And next to the pet that I approved, I do not see a button to approve this pet
# And instead I see an indicator next to the pet that they have been approved
