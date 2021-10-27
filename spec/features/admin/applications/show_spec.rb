require 'rails_helper'

RSpec.describe 'admin applications show page' do
  describe 'when i visit an admin show page' do
    before :each do
      @application = create(:application)
      @pet1 = create(:pet, application_id: @application.id)
      @pet2 = create(:pet, application_id: @application.id)
      @pet3 = create(:pet, application_id: @application.id)

      visit admin_application_path(@application)
    end

    it 'i see a button next to each pet to approve that specific pet' do
      within("#pet-#{@pet1.id}") do
        click_button 'Approve'
      end

      expect(current_path).to eq(admin_application_path(@application))

      within("#pet-#{@pet1.id}") do
        expect(page).to_not have_button('Approve')
        expect(page).to have_content("#{@pet1.name} is approved for this application")
      end
    end
  end
end
