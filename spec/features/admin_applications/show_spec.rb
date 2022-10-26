require 'rails_helper'

RSpec.describe 'admin applications show page' do
  before(:each) do
    @shelter_1 = Shelter.create!(name: 'Durango shelter', city: 'Durango, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create!(name: 'Athens Area Humane', city: 'Athens, GA', foster_program: true, rank: 7)
    @shelter_3 = Shelter.create!(name: 'Bend City Shelter', city: 'Bend, OR', foster_program: true, rank: 8)
    @shelter_4 = Shelter.create!(name: 'Cats and Dogs of Chicago', city: 'Chicago, IL', foster_program: false, rank: 3)
    @pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: @shelter_1.id)
    @pet_2 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: @shelter_2.id)
    @pet_3 = Pet.create(adoptable: false, age: 8, breed: 'mix', name: 'Kumquat', shelter_id: @shelter_3.id)
    @pet_4 = Pet.create(adoptable: true, age: 8, breed: 'calico', name: 'Donuts', shelter_id: @shelter_3.id)
    @pet_5 = Pet.create(adoptable: false, age: 8, breed: 'corgie', name: 'Squeeker', shelter_id: @shelter_4.id)
    @application_1 = Application.create!(name: 'Pam Pulzone', street_address: '66225 Wallace Rd', city: 'Bend', state: 'OR', zip: 97702, description: 'Fenced yard, loving home', status: 'Pending')
    @application_2 = Application.create!(name: 'Dan Boston', street_address: '774 Boone Rd', city: 'Greenville', state: 'SC', zip: 56843, description: 'Experience with difficult dogs', status:  'Pending')
    @application_pet_1 = ApplicationPet.create!(application: @application_1, pet: @pet_1)
    @application_pet_2 = ApplicationPet.create!(application: @application_1, pet: @pet_3)
  end
  
  it 'shows an applications details with button' do
    visit "/admin/applications/#{@application_1.id}"

    within("#pet-#{@pet_1.id}") do
      have_button?("Approve")
      have_button?("Reject")
    end

    within("#pet-#{@pet_3.id}") do
      have_button?("Approve")
      have_button?("Reject")
    end
  end

  it 'when approve button clicked taken back to the admin show page and no longer button to approve pet' do
    visit "/admin/applications/#{@application_1.id}"

    within("#pet-#{@pet_1.id}") do
      choose(:status, option: 'Approved')
      click_on "Submit"
    end

    expect(current_path).to eq("/admin/applications/#{@application_1.id}")
    
    within("#pet-#{@pet_1.id}") do
      has_no_button?("Approve")
      has_no_button?("Reject")
      expect(page).to have_content("Approved")
    end

    within("#pet-#{@pet_3.id}") do
      have_button?("Approve")
      have_button?("Reject")
      expect(page).to_not have_content("Approved")
    end
  end

  it 'can reject a pet for an application' do
    visit "/admin/applications/#{@application_1.id}"

    within("#pet-#{@pet_1.id}") do
      choose(:status, option: 'Rejected')
      click_on "Submit"
    end

    expect(current_path).to eq("/admin/applications/#{@application_1.id}")
    
    within("#pet-#{@pet_1.id}") do
      has_no_button?("Approve")
      has_no_button?("Reject")
      expect(page).to have_content("Rejected")
    end

    within("#pet-#{@pet_3.id}") do
      have_button?("Approve")
      have_button?("Reject")
      expect(page).to_not have_content("Rejected")
    end
  end

  it 'can accept one pet and reject another' do
    visit "/admin/applications/#{@application_1.id}"

    within("#pet-#{@pet_1.id}") do
      choose(:status, option: 'Rejected')
      click_on "Submit"
    end

    expect(current_path).to eq("/admin/applications/#{@application_1.id}")
    
    within("#pet-#{@pet_1.id}") do
      has_no_button?("Approve")
      has_no_button?("Reject")
      expect(page).to have_content("Rejected")
    end
  
    within("#pet-#{@pet_3.id}") do
      have_button?("Approve")
      have_button?("Reject")
      expect(page).to_not have_content("Rejected")
      
      choose(:status, option: 'Approved')
      click_on "Submit"
    end
    
    expect(current_path).to eq("/admin/applications/#{@application_1.id}")

    within("#pet-#{@pet_1.id}") do
      has_no_button?("Approve")
      has_no_button?("Reject")
      expect(page).to have_content("Rejected")
      expect(page).to_not have_content("Accepted")
    end

    within("#pet-#{@pet_3.id}") do
      has_no_button?("Approve")
      has_no_button?("Reject")
      expect(page).to have_content("Approved")
      expect(page).to_not have_content("Rejected")
    end
  end

  it 'can approve more than one pet on an application' do
    visit "/admin/applications/#{@application_1.id}"

    within("#pet-#{@pet_1.id}") do
      choose(:status, option: 'Approved')
      click_on "Submit"
    end

    expect(current_path).to eq("/admin/applications/#{@application_1.id}")
    
    within("#pet-#{@pet_1.id}") do
      has_no_button?("Approve")
      has_no_button?("Reject")
      expect(page).to have_content("Approved")
    end
  
    within("#pet-#{@pet_3.id}") do
      have_button?("Approve")
      have_button?("Reject")
      expect(page).to_not have_content("Approved")
      
      choose(:status, option: 'Approved')
      click_on "Submit"
    end
    
    expect(current_path).to eq("/admin/applications/#{@application_1.id}")

    within("#pet-#{@pet_1.id}") do
      has_no_button?("Approve")
      has_no_button?("Reject")
      expect(page).to have_content("Approved")
      expect(page).to_not have_content("Rejected")
    end

    within("#pet-#{@pet_3.id}") do
      has_no_button?("Approve")
      has_no_button?("Reject")
      expect(page).to have_content("Approved")
      expect(page).to_not have_content("Rejected")
    end
  end

  it 'can reject more than one pet on an application' do
    visit "/admin/applications/#{@application_1.id}"

    within("#pet-#{@pet_1.id}") do
      choose(:status, option: 'Rejected')
      click_on "Submit"
    end

    expect(current_path).to eq("/admin/applications/#{@application_1.id}")
    
    within("#pet-#{@pet_1.id}") do
      has_no_button?("Approve")
      has_no_button?("Reject")
      expect(page).to have_content("Rejected")
    end

    within("#pet-#{@pet_3.id}") do
      have_button?("Approve")
      have_button?("Reject")
      expect(page).to_not have_content("Approved")
      
      choose(:status, option: 'Rejected')
      click_on "Submit"
    end
    
    expect(current_path).to eq("/admin/applications/#{@application_1.id}")

    within("#pet-#{@pet_1.id}") do
      has_no_button?("Approve")
      has_no_button?("Reject")
      expect(page).to have_content("Rejected")
      expect(page).to_not have_content("Approved")
    end

    within("#pet-#{@pet_3.id}") do
      has_no_button?("Approve")
      has_no_button?("Reject")
      expect(page).to have_content("Rejected")
      expect(page).to_not have_content("Approved")
    end
  end
end