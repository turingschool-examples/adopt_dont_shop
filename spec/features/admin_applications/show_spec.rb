require 'rails_helper'

RSpec.describe 'Application show view' do
  before :each do
    @shelter = Shelter.create(name: 'Aurora shelter', street_address: '1234 Main St', city: 'Aurora, CO', zip_code: 80014, foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', street_address: '1568 1st St', city: 'Harlingen, TX', zip_code: 59235, foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', street_address: '9536 W 32nd Ave', city: 'Denver, CO', zip_code: 80220, foster_program: true, rank: 10)

    @application = Application.create({
                                        name: 'Jeff',
                                        street_address: '123 Main Street',
                                        city: 'Denver',
                                        state: 'CO',
                                        zip_code: 22_314,
                                        reason: 'Nice person'
                                      })
    @pet_3 = Pet.create(adoptable: true, age: 2, breed: 'Shih-Poo', name: 'Frankie', shelter_id: @shelter.id)
  end

  it 'has the ability to approve a pet' do
    @pet_1 = @application.pets.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald',
                                      shelter_id: @shelter.id)
    @pet_2 = @application.pets.create(adoptable: true, age: 5, breed: 'lab', name: 'Dogmin', shelter_id: @shelter.id)

    visit "/admin/applications/#{@application.id}"
    expect(page).to have_content('Jeff')
    expect(page).to have_content('123 Main Street, Denver CO, 22314')
    expect(page).to have_content('Nice person')
    expect(page).to have_content('Lucille Bald')
    expect(page).to have_content('Dogmin')
    expect(page).to have_content('In Progress')

    click_button 'Approve Dogmin'

    expect(current_path).to eq("/admin/applications/#{@application.id}")
    expect(page).to_not have_content('Approve Dogmin')
    expect(page).to have_content('Approved')
  end

  it 'has the ability to reject a pet' do
    @pet_1 = @application.pets.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald',
                                      shelter_id: @shelter.id)
    @pet_2 = @application.pets.create(adoptable: true, age: 5, breed: 'lab', name: 'Dogmin', shelter_id: @shelter.id)

    visit "/admin/applications/#{@application.id}"
    expect(page).to have_content('Jeff')
    expect(page).to have_content('123 Main Street, Denver CO, 22314')
    expect(page).to have_content('Nice person')
    expect(page).to have_content('Lucille Bald')
    expect(page).to have_content('Dogmin')
    expect(page).to have_content('In Progress')

    click_button 'Reject Dogmin'

    expect(current_path).to eq("/admin/applications/#{@application.id}")
    expect(page).to_not have_button('Reject Dogmin')
    expect(page).to have_content('Rejected')
  end

  it 'approval or rejection on one application does not affect another' do
    @pet_1 = @application.pets.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald',
                                      shelter_id: @shelter.id)
    @pet_2 = @application.pets.create(adoptable: true, age: 5, breed: 'lab', name: 'Dogmin', shelter_id: @shelter.id)
    @application_2 = Application.create!({
                                           name: 'Sam',
                                           street_address: '31779 Quarterhorse Rd',
                                           city: 'Evergreen',
                                           state: 'CO',
                                           zip_code: 80_439,
                                           reason: 'Because!'
                                         })

    ApplicationPet.create!(pet_id: @pet_2.id, application_id: @application_2.id)

    visit "/admin/applications/#{@application.id}"
    expect(page).to have_content('Jeff')
    expect(page).to have_content('123 Main Street, Denver CO, 22314')
    expect(page).to have_content('Nice person')
    expect(page).to have_content('Lucille Bald')
    expect(page).to have_content('Dogmin')
    expect(page).to have_content('In Progress')

    click_button 'Reject Dogmin'

    visit "/admin/applications/#{@application_2.id}"

    expect(page).to_not have_content('Rejected')
    expect(page).to have_button('Reject Dogmin')
    expect(page).to have_button('Approve Dogmin')
  end

  it 'approves the application if all pets are approved' do
    @pet_1 = @application.pets.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald',
                                      shelter_id: @shelter.id)
    @pet_2 = @application.pets.create(adoptable: true, age: 5, breed: 'lab', name: 'Dogmin', shelter_id: @shelter.id)
    @application_2 = Application.create!({
                                           name: 'Sam',
                                           street_address: '31779 Quarterhorse Rd',
                                           city: 'Evergreen',
                                           state: 'CO',
                                           zip_code: 80_439,
                                           reason: 'Because!'
                                         })

    ApplicationPet.create!(pet_id: @pet_2.id, application_id: @application_2.id)

    visit "/admin/applications/#{@application.id}"

    click_button 'Approve Dogmin'
    click_button 'Approve Lucille Bald'

    expect(page).to have_content('Status: Approved')
    expect(page).to_not have_content('Status: In Progress')
  end

  it 'rejects the application if any pets are rejected' do
    @pet_1 = @application.pets.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald',
                                      shelter_id: @shelter.id)
    @pet_2 = @application.pets.create(adoptable: true, age: 5, breed: 'lab', name: 'Dogmin', shelter_id: @shelter.id)
    @application_2 = Application.create!({
                                           name: 'Sam',
                                           street_address: '31779 Quarterhorse Rd',
                                           city: 'Evergreen',
                                           state: 'CO',
                                           zip_code: 80_439,
                                           reason: 'Because!'
                                         })

    ApplicationPet.create!(pet_id: @pet_2.id, application_id: @application_2.id)

    visit "/admin/applications/#{@application.id}"

    click_button 'Reject Dogmin'
    click_button 'Approve Lucille Bald'

    expect(page).to have_content('Status: Rejected')
    expect(page).to_not have_content('Status: In Progress')
    expect(page).to_not have_content('Status: Approved')
  end

  it 'makes pets not adoptable if they are part of an approved application' do
    @pet_1 = @application.pets.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald',
                                      shelter_id: @shelter.id)
    @pet_2 = @application.pets.create(adoptable: true, age: 5, breed: 'lab', name: 'Dogmin', shelter_id: @shelter.id)
    @application_2 = Application.create!({
                                           name: 'Sam',
                                           street_address: '31779 Quarterhorse Rd',
                                           city: 'Evergreen',
                                           state: 'CO',
                                           zip_code: 80_439,
                                           reason: 'Because!'
                                         })

    ApplicationPet.create!(pet_id: @pet_2.id, application_id: @application_2.id)

    visit "/admin/applications/#{@application.id}"

    click_button 'Approve Dogmin'
    click_button 'Approve Lucille Bald'

    visit "/pets/#{@pet_1.id}"

    expect(page).to have_content(false)
    expect(page).to_not have_content(true)

    visit "/pets/#{@pet_2.id}"

    expect(page).to have_content(false)
    expect(page).to_not have_content(true)
  end

  it 'does not allow approval of a pet if they are already part of an approved application' do
    @pet_1 = @application.pets.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald',
                                      shelter_id: @shelter.id)
    @pet_2 = @application.pets.create(adoptable: true, age: 5, breed: 'lab', name: 'Dogmin', shelter_id: @shelter.id)
    @application_2 = Application.create!({
                                           name: 'Sam',
                                           street_address: '31779 Quarterhorse Rd',
                                           city: 'Evergreen',
                                           state: 'CO',
                                           zip_code: 80_439,
                                           reason: 'Because!'
                                         })

    ApplicationPet.create!(pet_id: @pet_2.id, application_id: @application_2.id)

    visit "/admin/applications/#{@application.id}"

    click_button 'Approve Dogmin'
    click_button 'Approve Lucille Bald'

    visit "/admin/applications/#{@application_2.id}"

    expect(page).to have_content('Dogmin has been approved on a different application')
    expect(page).to_not have_button('Approve Dogmin')
  end
end
