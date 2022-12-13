require 'rails_helper'
require 'test_helper'

# As a visitor
# When I visit an admin application show page ('/admin/applications/:id')
# For every pet that the application is for, I see a button to approve the application for that specific pet
# When I click that button
# Then I'm taken back to the admin application show page
# And next to the pet that I approved, I do not see a button to approve this pet
# And instead I see an indicator next to the pet that they have been approved

RSpec.describe 'AdminApplication show page' do
  describe 'User story 12' do
    it 'application information and associated pet applying for' do
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
     
      visit "/admin/applications/#{@application_1.id}"

      expect(page).to have_content(@application_1.name)
      expect(page).to have_content(@application_1.full_address)
      expect(page).to have_content(@pet_1.name)
      expect(page).to have_content(@pet_2.name)
      expect(page).to have_content(@application_1.status)
    end

    it 'has a button to approve a specific pet' do
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

      visit "/admin/applications/#{@application_1.id}"

      expect(page).to have_button('Approve')
    end

    it 'can approve adoption when the button is pressed' do
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

      visit "/admin/applications/#{@application_1.id}"
      
      within("#pet-#{@pet_1.id}") do
        click_button('Approve')
      end
      expect(has_current_path?("/admin/applications/#{@application_1.id}?adopt=#{@pet_1.id}")).to be(true)
      expect(page).to_not have_button('Approve')
      expect(page).to have_content(@pet_1.name)
    end
  end
end