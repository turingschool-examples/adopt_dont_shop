# Application Show Page

# As a visitor
# When I visit an applications show page
# Then I can see the following:
# - Name of the Applicant
# - Full Address of the Applicant including street address, city, state, and zip code
# - Description of why the applicant says they'd be a good home for this pet(s)
# - names of all pets that this application is for (all names of pets should be links to their show page)
# - The Application's status, either "In Progress", "Pending", "Accepted", or "Rejected"

require 'rails_helper'

RSpec.describe 'the app show' do
  before :each do
    shelter = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    @pet_1 = Pet.create(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
    @pet_2 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: shelter.id)
    @app = Application.create(name: "John Smith", address: "123 Main St", city: "Denver", state: "CO", zipcode: "80120")
    ApplicationPet.create!(application_id: @app.id, pet_id: @pet_1.id)
  end

  it "shows the app and all its attributes" do
    visit "/applications/#{@app.id}"
    expect(page).to have_content(@app.name)
    expect(page).to have_content(@app.address)
    expect(page).to have_content(@app.city)
    expect(page).to have_content(@app.state)
    expect(page).to have_content(@app.zipcode)
    expect(page).to have_content(@app.about)
    expect(page).to have_link(@pet_1.name)
    expect(page).to have_content(@app.status)
    click_link("#{@pet_1.name}")
    expect(current_path).to eq("/pets/#{@pet_1.id}")
  end

  # As a visitor
  # When I visit an application's show page
  # And that application has not been submitted,
  # Then I see a section on the page to "Add a Pet to this Application"
  # In that section I see an input where I can search for Pets by name
  # When I fill in this field with a Pet's name
  # And I click submit,
  # Then I am taken back to the application show page
  # And under the search bar I see any Pet whose name matches my search
  it 'has an add pet section' do
    visit "/applications/#{@app.id}"

    within '#add_pet' do
      expect(page).to have_content('Add a Pet to this Application')
      expect(find('form')).to have_content('Search by Name')

      fill_in 'Search by Name', with: 'Bare-y'
      click_button 'Search'
    end

    within '#add_pet' do
      expect(page).to have_content(@pet_2.name)
    end
  end

  it 'can add pets to be adopted to the app' do
    visit "/applications/#{@app.id}"

    within '#add_pet' do
      fill_in 'Search by Name', with: 'Bare-y'
      click_button 'Search'
    end

    within '#adopt' do
      click_button 'Adopt this pet'
    end

    expect(page).to have_link(@pet_1.name)
    expect(page).to have_link(@pet_2.name)
  end

  it 'can submit applications' do
    visit "/applications/#{@app.id}"
    within '#add_pet' do

      fill_in 'Search by Name', with: 'Bare-y'
      click_button 'Search'
      click_button 'Adopt this pet'
    end
    expect(page).to have_button('Submit Application')
  end

  it 'can take input for adoption rationale' do
    visit "/applications/#{@app.id}"
    within '#add_pet' do

      fill_in 'Search by Name', with: 'Bare-y'
      click_button 'Search'
      click_button 'Adopt this pet'
    end
    expect(page).to have_field('about')
  end

  it 'will change the application status and about me when the button is pressed' do
    visit "/applications/#{@app.id}"
    old_about = @app.about
    within '#add_pet' do

      fill_in 'Search by Name', with: 'Bare-y'
      click_button 'Search'
      click_button 'Adopt this pet'
    end
    fill_in 'Why would you be a good fit?', with: 'I have a billion dollars and theyre all for him, my beloved Bare-y'
    click_button 'Submit Application'

    expect(page).to have_content('Pending')
    expect(page).to have_content('I have a billion dollars and theyre all for him, my beloved Bare-y')
    expect(page).to_not have_content(old_about)
  end

  it 'wont show submit button until there are pets on the app' do
    @app_no_pets = Application.create(name: "Nopets McGoo", address: "Nowhere", city: "Omaha", state: "NE", zipcode: "55555")
    visit "/applications/#{@app_no_pets.id}"
    expect(page).to_not have_button('Submit Application')
  end

  it 'doesnt allow for pets to be added or searched when app status is not "in progress"' do
    visit "/applications/#{@app.id}"
    expect(page).to have_content('In Progress')

    within '#add_pet' do
      expect(page).to have_content('Add a Pet to this Application')
      expect(find('form')).to have_content('Search by Name')

      fill_in 'Search by Name', with: 'Bare-y'
      click_button 'Search'
      click_button 'Adopt this pet'
    end

    fill_in 'Why would you be a good fit?', with: 'I have a billion dollars and theyre all for him, my beloved Bare-y'
    click_button 'Submit Application'
    refresh
    expect(page).to have_content('Pending')
    expect(page).to_not have_content('Add a Pet to this Application')
    expect(page).to_not have_field('Search by Name')
  end
end
