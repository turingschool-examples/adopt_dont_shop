require 'rails_helper'

RSpec.describe 'Admin Applications Show Page' do
  before do
    Application.destroy_all
    Pet.destroy_all
    Shelter.destroy_all

    @shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @bald = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Bald', shelter_id: @shelter.id)
    @lobster = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: @shelter.id)
    @skeeter = Pet.create!(adoptable: true, age: 7, breed: 'corgie', name: 'Skeeter', shelter_id: @shelter.id)
    @skippy = Pet.create!(adoptable: true, age: 5, breed: 'lab', name: 'skippy', shelter_id: @shelter.id)
    @bonds= Application.create!(name: 'Barry Bonds', address: '100 main street, Aurora, CO, 80014', description: 'I love dogs', pet_names: "#{@skeeter.id}, #{@lobster.id}", status: 1)
    @app_pet1 = ApplicationPet.create!(application: @bonds, pet: @skeeter)
    @app_pet2 = ApplicationPet.create!(application: @bonds, pet: @lobster)
  end

  describe 'As a visitor' do

    it 'For every pet on the app, I see a button to approve the application for that specific pet' do

      visit "/admin/applications/#{@bonds.id}"
      save_and_open_page
      within "pet-#{@skeeter.id}" do
          click_on "APPROVE"
      end
      expect(current_path).to eq("/admin/applications/#{@bonds.id}")
      within "pet-#{@skeeter.id}" do
        expect(page).to have_content("This Pet Has Been Approved!")
        expect(page).to_not have_content("APPROVE")
      end

    end

  end






end
