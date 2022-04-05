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
    @sosa = Application.create!(name: 'Sammy Sosa', address: '9042 Cork Blvd, Denver, CO, 802200', description: 'I corked my bad', pet_names: "#{@skeeter.id}, #{@lobster.id}", status: 1)
    @app_pet1 = ApplicationPet.create!(application: @bonds, pet: @skeeter, pet_status: 0)
    @app_pet2 = ApplicationPet.create!(application: @bonds, pet: @lobster, pet_status: 0)

    @app_pet3 = ApplicationPet.create!(application: @sosa, pet: @skeeter, pet_status: 0)
    @app_pet4 = ApplicationPet.create!(application: @sosa, pet: @lobster, pet_status: 0)

  end

  describe 'As a visitor' do

    it 'For every pet on the app, I see a button to approve that specific pet' do

      visit "/admin/applications/#{@bonds.id}"
      within "#pet-#{@lobster.id}" do
          click_on "APPROVE THIS PET"
      end
      expect(current_path).to eq("/admin/applications/#{@bonds.id}")
      # save_and_open_page
      within "#pet-#{@lobster.id}" do
        expect(page).to have_content("This Pet Has Been Approved!")
        expect(page).to_not have_content("APPROVE THIS PET")
      end
      within "#pet-#{@skeeter.id}" do
        expect(page).to_not have_content("This Pet Has Been Approved!")
      end
    end

    it 'For every pet on the app, I see a button to deny that specific pet' do
      visit "/admin/applications/#{@bonds.id}"
      # save_and_open_page
      within "#pet-#{@skeeter.id}" do
          click_on "DENY THIS PET"
      end
      expect(current_path).to eq("/admin/applications/#{@bonds.id}")
      # save_and_open_page
      within "#pet-#{@skeeter.id}" do
        expect(page).to have_content("This Pet Has Been Denied!")
        expect(page).to_not have_content("DENY THIS PET")
      end
    end

    it 'Approving/Denying a pet on one application show page doesnt effect another app with same pets' do
      visit "/admin/applications/#{@bonds.id}"

      within "#pet-#{@skeeter.id}" do
        click_on "DENY THIS PET"
      end
      within "#pet-#{@lobster.id}" do
        click_on "APPROVE THIS PET"
      end

      visit "/admin/applications/#{@sosa.id}"
      # save_and_open_page
      within "#pet-#{@skeeter.id}" do
        expect(page).to_not have_content("This Pet Has Been Denied!")
        expect(page).to_not have_content("This Pet Has Been Approved!")

      end
      within "#pet-#{@lobster.id}" do
        expect(page).to_not have_content("This Pet Has Been Approved!")
        expect(page).to_not have_content("This Pet Has Been Denied!")
      end
    end

    it 'I approve all pets on an application, I see the application status is now Approved' do

      visit "/admin/applications/#{@bonds.id}"

      within "#pet-#{@skeeter.id}" do
        click_on "APPROVE THIS PET"
      end
      within "#pet-#{@lobster.id}" do
        click_on "APPROVE THIS PET"
      end
      # save_and_open_page
      expect(page).to have_content("Application Status: accepted")

    end

    it 'I deny a single pet on an application, I see the application status is now rejected' do
      visit "/admin/applications/#{@bonds.id}"

      within "#pet-#{@skeeter.id}" do
        click_on "DENY THIS PET"
      end
      within "#pet-#{@lobster.id}" do
        click_on "APPROVE THIS PET"
      end
      # save_and_open_page
      expect(page).to have_content("Application Status: rejected")
    end

    it 'i approve all pets on an app, visiting those pet show pages show no longer adoptable' do
      visit "/admin/applications/#{@bonds.id}"

      within "#pet-#{@skeeter.id}" do
        click_on "APPROVE THIS PET"
      end
      within "#pet-#{@lobster.id}" do
        click_on "APPROVE THIS PET"
      end
      expect(page).to have_content("Application Status: accepted")
      visit "/pets/#{@skeeter.id}"
      # save_and_open_page
      expect(page).to have_content("false")
      expect(page).to_not have_content("true")

      visit "/pets/#{@skeeter.id}"
      expect(page).to have_content("false")
      expect(page).to_not have_content("true")

    end



  end






end
