require 'rails_helper'

RSpec.describe 'admin application show page' do
  before (:each) do
    @application_1 = Application.create!(
      name: 'Anita Barker',
      street_address: '2468 Park Blvd.',
      city: 'Denver',
      state: 'CO',
      zipcode: '80202',
      description: 'none',
      status: 'Pending'
      )
    @application_2 = Application.create!(
      name: 'Bob Barker',
      street_address: '1357 20th st.',
      city: 'Golden',
      state: 'CO',
      zipcode: '80209',
      description: 'na',
      status: 'pending'
      )
    @shelter_1 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @pet_3 = @shelter_1.pets.create(name: "Sammy", breed: "daschund", age: 8, adoptable: true)
    @pet_app1 = PetApplication.create!(pet: @pet_1, application: @application_1)
    @pet_app2 = PetApplication.create!(pet: @pet_2, application: @application_1)
    @pet_app3 = PetApplication.create!(pet: @pet_1, application: @application_2)
    @pet_app4 = PetApplication.create!(pet: @pet_2, application: @application_2)
  end

  it 'has a button to approve each pet on an application' do
    visit "/admin/applications/#{@application_1.id}"

    within ".pet_app-#{@pet_app1.id}" do
      click_on("Approve")
    end
    expect(current_path).to eq("/admin/applications/#{@application_1.id}")

    within ".pet_app-#{@pet_app1.id}" do
      expect(page).not_to have_button("Approve")
      expect(page).to have_content("Approved for Adoption")
    end

    within ".pet_app-#{@pet_app2.id}" do
      click_on("Approve")
    end
    expect(current_path).to eq("/admin/applications/#{@application_1.id}")
    within ".pet_app-#{@pet_app2.id}" do
      expect(page).not_to have_button("Approve")
      expect(page).to have_content("Approved for Adoption")
    end
  end

  it 'can reject a pet for adoption' do
    visit "/admin/applications/#{@application_1.id}"

    @application_1.pet_applications.each do |pet_app|
      within ".pet_app-#{pet_app.id}" do
        click_on("Reject")
      end
      expect(current_path).to eq("/admin/applications/#{@application_1.id}")
      within ".pet_app-#{pet_app.id}" do
        expect(page).not_to have_button("Reject")
        expect(page).to have_content("Not Approved")
      end
    end
  end

  it 'approval or rejection on one application does not affect other applications' do
    visit "/admin/applications/#{@application_1.id}"

    within ".pet_app-#{@pet_app1.id}" do
      click_on("Approve")
    end

    visit "/admin/applications/#{@application_2.id}"

    within ".pet_app-#{@pet_app3.id}" do
      expect(page).to have_button("Approve")
      expect(page).to have_button("Reject")
    end

    within ".pet_app-#{@pet_app4.id}" do
      click_on("Approve")
    end

    visit "/admin/applications/#{@application_1.id}"

    within ".pet_app-#{@pet_app2.id}" do
      expect(page).to have_button("Approve")
      expect(page).to have_button("Reject")
    end
  end

  it 'once a pet is on an approved application, that pet is no longer adoptable' do
    visit "/admin/applications/#{@application_1.id}"
    @application_1.pet_applications.each do |pet_app|
      within ".pet_app-#{pet_app.id}" do
        click_on("Approve")
      end
    end

    approved_app = Application.find(@application_1.id)
    expect(approved_app.status).to eq("Approved")

    visit "/pets/#{@pet_1.id}"
    expect(page).to have_content("false")

    visit "/pets/#{@pet_2.id}"
    expect(page).to have_content("false")

    visit "/pets/#{@pet_3.id}"
    expect(page).to have_content("true")
  end
end
