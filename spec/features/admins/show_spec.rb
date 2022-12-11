require 'rails_helper'

RSpec.describe 'admin show page' do
  before :each do
    @shelter = Shelter.create!(name: 'Snoops Dogs', city: 'Compton', rank: 1, foster_program: true)

    @fred = @shelter.pets.create!(adoptable: true, age: 8, breed: 'Basset Hound', name: 'Fred')
    @james = @shelter.pets.create!(adoptable: true, age: 4, breed: 'King George Spaniel', name: 'James')
    @buster = @shelter.pets.create!(adoptable: true, age: 2, breed: 'Shnauzer - Wheaton mix', name: 'Buster')
    @marlowe = @shelter.pets.create!(adoptable: true, age: 9, breed: 'Pembroke Welsh Corgi', name: 'Marlowe')

    @app1 = Application.create!(
      name: 'Frank Sinatra',
      street_address: '69 Sinatra Way',
      city: 'Nashville',
      state: 'Tennessee', zip_code: '69420', description: "I've always liked dogs",
      status: 'In Progress'
    )
  end

  it 'has a button next to each pet on the application allowing me to approve that application' do
    PetApplication.create!(pet: @buster, application: @app1)
    PetApplication.create!(pet: @marlowe, application: @app1)

    visit "/admin/applications/#{@app1.id}"

    within "#pet-#{@buster.id}" do
      expect(page).to have_button('Approve This Application')
      expect(page).to have_content('Buster')
    end

    within "#pet-#{@marlowe.id}" do
      expect(page).to have_button('Approve This Application')
      expect(page).to have_content('Marlowe')
    end

    within "#pet-#{@buster.id}" do
      click_button("Approve This Application")
    end

    expect(current_path).to eq("/admin/applications/#{@app1.id}")

    within "#pet-#{@buster.id}" do
      expect(page).to_not have_button('Approve This Application')
      expect(page).to have_content("Application Approved!")
    end
save_and_open_page
    within "#pet-#{@marlowe.id}" do
      expect(page).to have_button('Approve This Application')
    end
  end

  it 'has a button to reject an application next to each pet' do
    PetApplication.create!(pet: @buster, application: @app1)
    PetApplication.create!(pet: @marlowe, application: @app1)

    visit "/admin/applications/#{@app1.id}"

    within "#pet-#{@buster.id}" do
      expect(page).to have_button('Reject This Application')
      expect(page).to have_content('Buster')
    end

    within "#pet-#{@marlowe.id}" do
      expect(page).to have_button('Reject This Application')
      expect(page).to have_content('Marlowe')
    end

    within "#pet-#{@marlowe.id}" do
      click_button("Reject This Application")
    end

    expect(current_path).to eq("/admin/applications/#{@app1.id}")

    within "#pet-#{@marlowe.id}" do
      expect(page).to_not have_button('Approve This Application')
      expect(page).to_not have_button('Reject This Application')
      expect(page).to have_content("Application Rejected")
    end

    within "#pet-#{@buster.id}" do
      expect(page).to have_button('Approve This Application')
      expect(page).to have_button('Reject This Application')
    end
  end


end