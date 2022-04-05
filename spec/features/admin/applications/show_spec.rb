require 'rails_helper'

RSpec.describe 'the admin applications show' do
  before(:each) do
    Shelter.destroy_all
    Pet.destroy_all
    Application.destroy_all
    ApplicationPet.destroy_all
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @pet_3 = @shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
    @application_1 = Application.create!(name: "Tyler R", street_address:"1000 Something Blvd", city: "Denver", state: "CO", zipcode: 80123)
    @application_2 = Application.create!(name: "Kim G", street_address:"2000 Something Blvd", city: "Denver", state: "CO", zipcode: 80124)
    @application_pet1 = ApplicationPet.create!(application: @application_1, pet: @pet_1)
    @application_1.description = "I am lonely and need fluffy mammals"
    @application_1.status = "Pending"
    @application_1.save
  end

  it 'approve a pet for adoption' do 
    visit "admin/applications/#{@application_1.id}"

    within("#pets_added-#{@pet_1.id}") do 
      click_button "Approve application for #{@pet_1.name}"

      expect(current_path).to eq("/admin/applications/#{@application_1.id}")
      application_pet_updated = ApplicationPet.find(@application_pet1.id)
    
      expect(page).to have_content("Application for #{@pet_1.name} #{application_pet_updated.status}")
      expect(page).to_not have_content("Approve application for #{@pet_1.name}")
    end
  end

  it 'rejects a pet for adoption' do 
    visit "admin/applications/#{@application_1.id}"

    within("#pets_added-#{@pet_1.id}") do 
      click_button "Reject application for #{@pet_1.name}"

      expect(current_path).to eq("/admin/applications/#{@application_1.id}")
      application_pet_updated = ApplicationPet.find(@application_pet1.id)
    
      expect(page).to have_content("Application for #{@pet_1.name} #{application_pet_updated.status}")
      expect(page).to_not have_content("Approve application for #{@pet_1.name}")
      expect(page).to_not have_content("Reject application for #{@pet_1.name}")
    end
  end

  it 'approves/rejects a pet for adoption does not affect other applications' do 
    visit "admin/applications/#{@application_1.id}"

    within("#pets_added-#{@pet_1.id}") do 
      click_button "Reject application for #{@pet_1.name}"
    end 

      @application_pet2 = ApplicationPet.create!(application: @application_2, pet: @pet_1)
      @application_2.description = "I am lonely and need fluffy mammals too"
      @application_2.status = "Pending"
      @application_2.save

      visit "/admin/applications/#{@application_2.id}"

      within("#pets_added-#{@pet_1.id}") do 
        expect(page).to_not have_content("Approve application for #{@pet_1.name}")
        expect(page).to_not have_content("Reject application for #{@pet_1.name}")
      end 
  
  end

  it 'changes application status to approved when all pets approved' do 



    application_3 = Application.create!(name: "Kim G", street_address:"2000 Something Blvd", city: "Denver", state: "CO", zipcode: 80128)
    application_pet3_1 = ApplicationPet.create!(application: application_3, pet: @pet_1)
    application_pet3_2 = ApplicationPet.create!(application: application_3, pet: @pet_2)
    application_3.description = "I am lonely and need fluffy mammals"
    application_3.status = "Pending"
    application_3.save
  
     visit "/admin/applications/#{application_3.id}"
  
    within("#pets_added-#{@pet_1.id}") do 
      click_button "Approve application for #{@pet_1.name}"
    end 

    visit "/admin/applications/#{application_3.id}"

    within("#pets_added-#{@pet_2.id}") do 
      click_button "Approve application for #{@pet_2.name}"
    end 

      expect(current_path).to eq("/admin/applications/#{application_3.id}")
      expect(page).to have_content('Application Status: Approved')
  end

end