require 'rails_helper'

describe 'Applications show page ' do
  it "for every pet I see a button to approve application" do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: false)
    @pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @pet_3 = @shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)

    @application_1 = Application.create!(name:'wade', address: '123 test st', city: 'bear', state: 'delaware', zip: '22222', description: 'sup', status: 'Pending')
    @application_2 = Application.create!(name:'brett', address: '123 test st', city: 'wilmington', state: 'delaware', zip: '11111', description: 'hi', status: 'Pending')
    @pet_application_1 = PetApplication.create!(pet_id: @pet_1.id, application_id: @application_1.id)
    @pet_application_2 = PetApplication.create!(pet_id: @pet_3.id, application_id: @application_2.id)

    visit "/admin/applications/#{@application_1.id}"

    expect(page).to have_button("Approve #{@pet_1.name}")
  end

  it "When I Approve I am taken back to admin application" do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: false)
    @pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @pet_3 = @shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)

    @application_1 = Application.create!(name:'wade', address: '123 test st', city: 'bear', state: 'delaware', zip: '22222', description: 'sup', status: 'Pending')
    @application_2 = Application.create!(name:'brett', address: '123 test st', city: 'wilmington', state: 'delaware', zip: '11111', description: 'hi', status: 'Pending')
    @pet_application_1 = PetApplication.create!(pet_id: @pet_1.id, application_id: @application_1.id)
    @pet_application_2 = PetApplication.create!(pet_id: @pet_3.id, application_id: @application_2.id)

    visit "/admin/applications/#{@application_1.id}"

    click_button("Approve #{@pet_1.name}")
    expect(current_path).to eq("/admin/applications/#{@application_1.id}")

  end

  it "Next to each that I approved i do not see a button to approve this pet and instead I see indicator that they have been approved " do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: false)
    @pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @pet_3 = @shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)

    @application_1 = Application.create!(name:'wade', address: '123 test st', city: 'bear', state: 'delaware', zip: '22222', description: 'sup', status: 'Pending')
    @application_2 = Application.create!(name:'brett', address: '123 test st', city: 'wilmington', state: 'delaware', zip: '11111', description: 'hi', status: 'Pending')
    @pet_application_1 = PetApplication.create!(pet_id: @pet_1.id, application_id: @application_1.id)
    @pet_application_2 = PetApplication.create!(pet_id: @pet_3.id, application_id: @application_2.id)
    visit "/admin/applications/#{@application_1.id}"

    click_button("Approve #{@pet_1.name}")
    expect(current_path).to eq("/admin/applications/#{@application_1.id}")
    expect(page).to_not have_button("Approve #{@pet_1.name}")
    expect(page).to have_content("Approved: #{@pet_1.name}")
  end

  it "for every pet I see a button to reject application" do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: false)
    @pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @pet_3 = @shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)

    @application_1 = Application.create!(name:'wade', address: '123 test st', city: 'bear', state: 'delaware', zip: '22222', description: 'sup', status: 'Pending')
    @application_2 = Application.create!(name:'brett', address: '123 test st', city: 'wilmington', state: 'delaware', zip: '11111', description: 'hi', status: 'Pending')
    @pet_application_1 = PetApplication.create!(pet_id: @pet_1.id, application_id: @application_1.id)
    @pet_application_2 = PetApplication.create!(pet_id: @pet_3.id, application_id: @application_2.id)

    visit "/admin/applications/#{@application_1.id}"

    expect(page).to have_button("Reject #{@pet_1.name}")
  end

  it "When I reject I am taken back to admin application" do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: false)
    @pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @pet_3 = @shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)

    @application_1 = Application.create!(name:'wade', address: '123 test st', city: 'bear', state: 'delaware', zip: '22222', description: 'sup', status: 'Pending')
    @application_2 = Application.create!(name:'brett', address: '123 test st', city: 'wilmington', state: 'delaware', zip: '11111', description: 'hi', status: 'Pending')
    @pet_application_1 = PetApplication.create!(pet_id: @pet_1.id, application_id: @application_1.id)
    @pet_application_2 = PetApplication.create!(pet_id: @pet_3.id, application_id: @application_2.id)

    visit "/admin/applications/#{@application_1.id}"

    click_button("Reject #{@pet_1.name}")
    expect(current_path).to eq("/admin/applications/#{@application_1.id}")

  end

  it "Next to each pet that I reject i do not see a button to reject this pet and instead I see indicator that they have been rejected " do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: false)
    @pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @pet_3 = @shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)

    @application_1 = Application.create!(name:'wade', address: '123 test st', city: 'bear', state: 'delaware', zip: '22222', description: 'sup', status: 'Pending')
    @application_2 = Application.create!(name:'brett', address: '123 test st', city: 'wilmington', state: 'delaware', zip: '11111', description: 'hi', status: 'Pending')
    @pet_application_1 = PetApplication.create!(pet_id: @pet_1.id, application_id: @application_1.id)
    @pet_application_2 = PetApplication.create!(pet_id: @pet_3.id, application_id: @application_2.id)
    visit "/admin/applications/#{@application_1.id}"

    click_button("Reject #{@pet_1.name}")
    expect(current_path).to eq("/admin/applications/#{@application_1.id}")
    expect(page).to_not have_button("Reject #{@pet_1.name}")
    expect(page).to have_content("Rejected: #{@pet_1.name}")
  end

end
