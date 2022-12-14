require 'rails_helper'
require 'test_helper'

RSpec.describe 'AdminApplication show page' do
  before :each do
    seed_shelters
    seed_pets
    seed_applications

    ApplicationPet.create!(
      application: @application_1, 
      pet: @pet_1
    )
    ApplicationPet.create!(
      application: @application_1, 
      pet: @pet_2
    )
  end

  describe 'User story 12' do
    it 'application information and associated pet applying for' do
      visit "/admin/applications/#{@application_1.id}"

      expect(page).to have_content(@application_1.name)
      expect(page).to have_content(@application_1.full_address)
      expect(page).to have_content(@pet_1.name)
      expect(page).to have_content(@pet_2.name)
      expect(page).to have_content(@application_1.status)
    end

    it 'has a button to approve a specific pet' do
      visit "/admin/applications/#{@application_1.id}"

      expect(page).to have_button('Approve')
    end
    
    it 'can approve adoption when the button is pressed' do
      visit "/admin/applications/#{@application_1.id}"

      within("#pet-#{@pet_1.id}") do
        click_button('Approve')
      end
      
      @application_1.reload
      expect(current_path).to eq("/admin/applications/#{@application_1.id}")
      
      within("#pet-#{@pet_1.id}") do
        expect(page).to_not have_button('Approve')
        expect(page).to have_content(@pet_1.name)
        expect(page).to have_content("#{@pet_1.name}'s application status is now: Approved")
        @pet_1.reload
      end
      
      within("#pet-#{@pet_2.id}") do
        click_button('Approve')
      end

      within("#pet-#{@pet_2.id}") do
        expect(page).to_not have_button('Approve')
        expect(page).to have_content(@pet_2.name)
        expect(page).to have_content("#{@pet_2.name}'s application status is now: Approved")
        @pet_2.reload
      end
    end
  end

  describe 'User story 13' do
    it 'has a button to reject a specific pet' do
      visit "/admin/applications/#{@application_1.id}"

      expect(page).to have_button('Reject')
    end

    it 'can reject adoption when the button is pressed' do
      visit "/admin/applications/#{@application_1.id}"

      within("#pet-#{@pet_1.id}") do
        click_button('Reject')
        expect(page).to have_content('Rejected')
      end

      expect(current_path).to eq("/admin/applications/#{@application_1.id}")
      within("#pet-#{@pet_1.id}") do
        expect(page).to_not have_button('Reject')
      end
      expect(page).to have_content(@pet_1.name)

      @application_1.reload
      @pet_1.reload
    end
  end

  describe 'User Story 14' do
    it "has individual approve/reject attributes for every application's pets" do
      ApplicationPet.create!(
        application: @application_2, 
        pet: @pet_1
      )
      ApplicationPet.create!(
        application: @application_2, 
        pet: @pet_2
      )

      visit "/admin/applications/#{@application_1.id}"

      within("#pet-#{@pet_1.id}") do
        click_button('Approve')
      end

      within("#pet-#{@pet_2.id}") do
        click_button('Reject')
      end

      visit "/admin/applications/#{@application_2.id}"

      within("#pet-#{@pet_1.id}") do
        expect(page).to have_button('Approve')
        expect(page).to have_button('Reject')
      end

      within("#pet-#{@pet_2.id}") do
        expect(page).to have_button('Approve')
        expect(page).to have_button('Reject')
      end
    end
  end
end 