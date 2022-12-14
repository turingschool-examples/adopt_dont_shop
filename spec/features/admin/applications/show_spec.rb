require 'rails_helper'

RSpec.describe 'admin applications show page' do
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
      click_button('Approve This Application')
    end

    expect(current_path).to eq("/admin/applications/#{@app1.id}")

    within "#pet-#{@buster.id}" do
      expect(page).to_not have_button('Approve This Application')
      expect(page).to have_content('Application Approved!')
    end

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
      click_button('Reject This Application')
    end

    expect(current_path).to eq("/admin/applications/#{@app1.id}")

    within "#pet-#{@marlowe.id}" do
      expect(page).to_not have_button('Approve This Application')
      expect(page).to_not have_button('Reject This Application')
      expect(page).to have_content('Application Rejected')
    end

    within "#pet-#{@buster.id}" do
      expect(page).to have_button('Approve This Application')
      expect(page).to have_button('Reject This Application')
    end
  end

  it 'approving or rejecting applications for pets on one app doesnt affect ability to do so on another app' do
    app2 = Application.create!(
      name: 'Alex Pitzel',
      street_address: '6969 Canuck Ave',
      city: 'Toronto',
      state: 'Canada, eh', zip_code: '32243', description: 'buster is my dog, fight me',
      status: 'In Progress'
    )
    PetApplication.create!(pet: @buster, application: @app1)
    PetApplication.create!(pet: @buster, application: app2)

    visit "/admin/applications/#{@app1.id}"

    within "#pet-#{@buster.id}" do
      click_button('Reject This Application')
    end

    visit "/admin/applications/#{app2.id}"

    within "#pet-#{@buster.id}" do
      expect(page).to have_button('Approve This Application')
      expect(page).to have_button('Reject This Application')
    end
  end

  it 'sets an applications status to approved if all pets are approved' do
    PetApplication.create!(pet: @buster, application: @app1)
    PetApplication.create!(pet: @marlowe, application: @app1)
    @app1.update(status: 'Pending')

    visit "/admin/applications/#{@app1.id}"
    expect(page).to have_content('Application Status: Pending')

    within "#pet-#{@buster.id}" do
      click_button('Approve This Application')
    end

    expect(page).to have_content('Application Status: Pending')

    within "#pet-#{@marlowe.id}" do
      click_button('Approve This Application')
    end

    expect(page).to have_content('Application Status: Approved')
  end

  it 'sets an application status to rejected if any of the pets on that application are rejected' do
    PetApplication.create!(pet: @buster, application: @app1)
    PetApplication.create!(pet: @marlowe, application: @app1)
    @app1.update(status: 'Pending')

    visit "/admin/applications/#{@app1.id}"
    expect(page).to have_content('Application Status: Pending')

    within "#pet-#{@buster.id}" do
      click_button('Approve This Application')
    end

    expect(page).to have_content('Application Status: Pending')

    within "#pet-#{@marlowe.id}" do
      click_button('Reject This Application')
    end

    expect(page).to have_content('Application Status: Rejected')
  end

  it 'does not allow an application to be approved on a pet when that pet has an approved application' do
    app2 = Application.create!(
      name: 'Alex Pitzel',
      street_address: '6969 Canuck Ave',
      city: 'Flavortown',
      state: 'Canada, eh', zip_code: '32243', description: 'buster is my dog, fight me',
      status: 'In Progress'
    )
    PetApplication.create!(pet: @buster, application: @app1)
    PetApplication.create!(pet: @buster, application: app2)
    @app1.update(status: 'Pending')
    app2.update(status: 'Pending')

    visit "/admin/applications/#{@app1.id}"
    within "#pet-#{@buster.id}" do
      click_button('Approve This Application')
    end
    expect(page).to have_content('Application Status: Approved')

    visit "/admin/applications/#{app2.id}"
    within "#pet-#{@buster.id}" do
      expect(page).to have_content(@buster.name)
      expect(page).to_not have_button('Approve This Application')
      expect(page).to have_button('Reject This Application')
      expect(page).to have_content('This Pet has been Approved for Adoption')
    end
  end
end
