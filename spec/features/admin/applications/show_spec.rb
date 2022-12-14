require 'rails_helper'

RSpec.describe 'admin applications show page' do
  before(:each) do
    @shelter_1       = create(:shelter)
    @pet_1           = create(:pet, shelter: @shelter_1)
    @application_1   = create(:application)
    @application_2   = create(:application)
    @application_1.pets << @pet_1
    @application_2.pets << @pet_1
  end
# As a visitor
# When I visit an admin application show page ('/admin/applications/:id')
# For every pet that the application is for, I see a button to approve the application for that specific pet
# When I click that button
# Then I'm taken back to the admin application show page
# And next to the pet that I approved, I do not see a button to approve this pet
# And instead I see an indicator next to the pet that they have been approved
  it 'will have an approve button next to each pet' do
    visit "/admin/applications/#{@application_1.id}" 

    expect(page).to have_button("Approve")

    visit "/applications/#{@application_1.id}"

    expect(page).to_not have_button("Approve")
  end

  it 'When the pet is approved, it removes the button and states the pet is approved' do
    visit "/admin/applications/#{@application_1.id}" 

    click_button "Approve"

    expect(page).to_not have_button("Approve")
    expect(page).to_not have_button("Reject")
    expect(page).to have_content("This pet has been approved")
  end

  it 'When the pet is rejected, it removes the buttons and states the pet is rejected' do
    visit "/admin/applications/#{@application_1.id}" 

    click_button "Reject"

    expect(page).to_not have_button("Approve")
    expect(page).to_not have_button("Reject")
    expect(page).to have_content("This pet has been rejected")
  end

  describe 'US 14' do
    it 'will a approve a pet on one application but not another' do

      visit "/admin/applications/#{@application_1.id}"
      pet_app_1 = PetApplication.where(pet_id: @pet_1.id, application_id: @application_1.id).first
      pet_app_2 = PetApplication.where(pet_id: @pet_1.id, application_id: @application_2.id).first
      # binding.pry
      # other_pet_app_1 = PetApplication.find_by(pet_id: @pet_1.id)

      expect(page).to have_content(@pet_1.name)
      expect(pet_app_1.status).to eq("pending")
      expect(pet_app_2.status).to eq("pending")

      click_button "Approve"
      pet_app_1.reload
      pet_app_2.reload

      expect(page).to have_content("This pet has been approved")
      expect(pet_app_1.status).to eq("accepted")
      expect(pet_app_2.status).to eq("pending")

      visit "/admin/applications/#{@application_2.id}"

      expect(page).to have_button("Approve")
      expect(page).to have_button("Reject")
      expect(page).to_not have_content("This pet has been approved")
    end

    it 'will a reject a pet on one application but not another' do

      visit "/admin/applications/#{@application_1.id}"
      pet_app_1 = PetApplication.where(pet_id: @pet_1.id, application_id: @application_1.id).first
      pet_app_2 = PetApplication.where(pet_id: @pet_1.id, application_id: @application_2.id).first

      expect(page).to have_content(@pet_1.name)
      expect(pet_app_1.status).to eq("pending")
      expect(pet_app_2.status).to eq("pending")

      click_button "Reject"
      pet_app_1.reload
      pet_app_2.reload

      expect(page).to have_content("This pet has been rejected")
      expect(pet_app_1.status).to eq("rejected")
      expect(pet_app_2.status).to eq("pending")

      visit "/admin/applications/#{@application_2.id}"

      expect(page).to have_button("Approve")
      expect(page).to have_button("Reject")
      expect(page).to_not have_content("This pet has been rejected")

    end
  end
end