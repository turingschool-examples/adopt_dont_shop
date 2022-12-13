# Name of the Applicant
# Full Address of the Applicant including street address, city, state, and zip code
# Description of why the applicant says they'd be a good home for this pet(s)
# names of all pets that this application is for (all names of pets should be links to their show page)
# The Application's status, either "In Progress", "Pending", "Accepted", or "Rejected"

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

  it 'displays an application and its information' do
    @pet_1 = @application.pets.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald',
                                      shelter_id: @shelter.id)
    @pet_2 = @application.pets.create(adoptable: true, age: 5, breed: 'lab', name: 'Dogmin', shelter_id: @shelter.id)

    visit "/applications/#{@application.id}"
    expect(page).to have_content('Jeff')
    expect(page).to have_content('123 Main Street, Denver CO, 22314')
    expect(page).to have_content('Nice person')
    expect(page).to have_content('Lucille Bald')
    expect(page).to have_content('Dogmin')
    expect(page).to have_content('In Progress')
  end

  it 'displays an application and its information' do
    @pet_1 = @application.pets.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald',
                                      shelter_id: @shelter.id)
    @pet_2 = @application.pets.create(adoptable: true, age: 5, breed: 'lab', name: 'Dogmin', shelter_id: @shelter.id)

    visit "/applications/#{@application.id}"

    click_on 'Dogmin'

    expect(current_path).to eq("/pets/#{@pet_2.id}")
  end

  it 'has a section to add a pet to the application' do
    visit "/applications/#{@application.id}"

    expect(page).to have_content('Add a new pet to this application:')

    fill_in('name_input', with: 'Frankie')

    click_button 'Search'

    expect(page).to have_content('Frankie')
  end

  it 'can add a pet to the application' do
    visit "/applications/#{@application.id}"

    expect(page).to have_content('Add a new pet to this application:')

    fill_in('name_input', with: 'Frankie')

    click_button 'Search'

    click_on 'Frankie'

    expect(current_path).to eq("/applications/#{@application.id}")

    click_on 'Frankie'

    expect(current_path).to eq("/pets/#{@pet_3.id}")
  end

  it 'can submit an application' do
    visit "/applications/#{@application.id}"

    expect(page).to have_content('Add a new pet to this application:')

    fill_in('name_input', with: 'Frankie')

    click_button 'Search'

    click_on 'Frankie'

    expect(current_path).to eq("/applications/#{@application.id}")

    fill_in('reason', with: 'I love him already')

    click_on 'Submit Application'

    expect(current_path).to eq("/applications/#{@application.id}")
    expect(page).to have_content('Frankie')
    expect(page).to_not have_content('Add a new pet to this application:')
    expect(page).to have_content('Pending')
  end

  it 'can submit an application' do
    visit "/applications/#{@application.id}"

    expect(page).to have_content('Add a new pet to this application:')
    expect(page).to_not have_content('Submit Application')
  end

  it 'searching for pets will return pets whose names partially match the search terms' do
    visit "/applications/#{@application.id}"

    expect(page).to have_content('Add a new pet to this application:')

    fill_in('name_input', with: 'Frank')

    click_button 'Search'

    click_on 'Frankie'

    expect(current_path).to eq("/applications/#{@application.id}")

    click_on 'Frankie'

    expect(current_path).to eq("/pets/#{@pet_3.id}")
  end

  it 'searching for pets will return pets whose names match regardless of the casing of the search terms' do
    visit "/applications/#{@application.id}"

    expect(page).to have_content('Add a new pet to this application:')

    fill_in('name_input', with: 'frankie')

    click_button 'Search'

    click_on 'Frankie'

    expect(current_path).to eq("/applications/#{@application.id}")

    click_on 'Frankie'

    expect(current_path).to eq("/pets/#{@pet_3.id}")
  end
end
