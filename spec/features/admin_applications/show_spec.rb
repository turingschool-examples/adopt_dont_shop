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
        application: @application_2, 
        pet: @pet_1
      )
      ApplicationPet.create!(
        application: @application_2, 
        pet: @pet_2
      )
      
      visit "/admin/applications/#{@application_2.id}"
      expect(@application_2.status).to eq('Pending')
      expect(page).to have_content('Pending')

      within("#pet-#{@pet_1.id}") do
        click_button('Approve')
      end
      
      @application_2.reload
      expect(current_path).to eq("/admin/applications/#{@application_2.id}")
      
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

# As a visitor
# When I visit an admin application show page ('/admin/applications/:id')
# For every pet that the application is for, I see a button to reject the application for that specific pet
# When I click that button
# Then I'm taken back to the admin application show page
# And next to the pet that I rejected, I do not see a button to approve or reject this pet
# And instead I see an indicator next to the pet that they have been rejected

  describe 'User story 13' do
    it 'has a button to reject a specific pet' do
      seed_shelters
      seed_pets
      seed_applications
      ApplicationPet.create!(
        application: @application_1, 
        pet: @pet_1
      )
  
      visit "/admin/applications/#{@application_1.id}"

      expect(page).to have_button('Reject')
    end

    it 'can reject adoption when the button is pressed' do
      seed_shelters
      seed_pets
      seed_applications
      ApplicationPet.create!(
        application: @application_2, 
        pet: @pet_1
      )
      
      visit "/admin/applications/#{@application_2.id}"
      expect(@application_2.status).to eq('Pending')
      expect(page).to have_content('Pending')

      within("#pet-#{@pet_1.id}") do
        click_button('Reject')
        expect(page).to have_content('Rejected')
      end

      expect(current_path).to eq("/admin/applications/#{@application_2.id}")
      expect(page).to_not have_button('Reject')
      expect(page).to have_content(@pet_1.name)

      @application_2.reload
      @pet_1.reload
    end
  end
end 