require 'rails_helper'

RSpec.describe 'admin applications show page' do
  describe 'when i visit an admin show page' do
    before :each do
      @application = create(:application)
      @pet1 = create(:pet)
      @pet2 = create(:pet)
      @pet3 = create(:pet)
      @ap1 = ApplicationPet.create(application_id: @application.id, pet_id: @pet1.id)
      @ap2 = ApplicationPet.create(application_id: @application.id, pet_id: @pet2.id)
      @ap3 = ApplicationPet.create(application_id: @application.id, pet_id: @pet3.id)

      visit admin_application_path(@application)
    end

    it 'i see a button next to each pet to approve that specific pet' do
      within("#app_pet-#{@ap1.id}") do
        expect(page).to have_content(@pet1.name)
        click_button "Approve"
      end

      expect(current_path).to eq(admin_application_path(@application))

      within("#app_pet-#{@ap1.id}") do
        expect(page).to_not have_button("Approve")
        expect(page).to_not have_button("Reject")
        expect(page).to have_content("#{@pet1.name} is approved for this application")
      end
    end

    it 'i see a button next to each pet to reject that specific pet' do
      within("#app_pet-#{@ap1.id}") do
        expect(page).to have_content(@pet1.name)
        click_button "Reject"
      end

      expect(current_path).to eq(admin_application_path(@application))

      within("#app_pet-#{@ap1.id}") do
        expect(page).to_not have_button("Approve")
        expect(page).to_not have_button("Reject")
        expect(page).to have_content("#{@pet1.name} has been rejected for this application")
      end
    end
  end
end
