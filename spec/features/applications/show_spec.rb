require 'rails_helper'

describe 'app show page' do
  #   1. app Show Page
  # As a visitor
  # When I visit an apps show page
  # Then I can see the following:
  # - Name of the Applicant
  # - Full Address of the Applicant including street address, city, state, and zip code
  # - Description of why the applicant says they'd be a good home for this pet(s)
  # - names of all pets that this app is for (all names of pets should be links to their show page)
  # - The app's status, either "In Progress", "Pending", "Accepted", or "Rejected"
  describe 'app details' do
    before(:each) do
      @app = Application.create!(name: 'John Smith',
                                 address: '123 Fake Street',
                                 city: 'Springfield',
                                 state: 'IL',
                                 zipcode: 12_345,
                                 description: 'I like dogs.',
                                 status: 'In Progress')
    end

    it 'has the name' do
      visit "/applications/#{@app.id}"
      expect(page).to have_content(@app.name)
    end
    it 'has the address' do
      visit "/applications/#{@app.id}"
      expect(page).to have_content(@app.address)
      expect(page).to have_content(@app.city)
      expect(page).to have_content(@app.state)
      expect(page).to have_content(@app.zipcode)
    end
    it 'has the description' do
      visit "/applications/#{@app.id}"
      expect(page).to have_content('I like dogs.')
    end
    it 'has all pets names' do
      shelter = Shelter.create!(
        foster_program: true,
        name: 'Dog house',
        city: 'Springfield',
        rank: 1
      )
      fido = shelter.pets.create!(
        adoptable: true,
        age: 1,
        breed: 'weiner',
        name: 'Fido'
      )
      santa = shelter.pets.create!(
        adoptable: true,
        age: 1,
        breed: 'whippet',
        name: 'Santa\'s Little Helper'
      )
      petapp1 = PetApplication.create!(application_id: @app.id, pet_id: fido.id)
      petapp2 = PetApplication.create!(application_id: @app.id, pet_id: santa.id)
      visit "/applications/#{@app.id}"
      expect(page).to have_content(santa.name)
      expect(page).to have_content(fido.name)
    end
    it 'pet names are links to the pet show page' do
      shelter = Shelter.create!(
        foster_program: true,
        name: 'Dog house',
        city: 'Springfield',
        rank: 1
      )
      fido = shelter.pets.create!(
        adoptable: true,
        age: 1,
        breed: 'weiner',
        name: 'Fido'
      )
      santa = shelter.pets.create!(
        adoptable: true,
        age: 1,
        breed: 'whippet',
        name: 'Santa\'s Little Helper'
      )
      petapp1 = PetApplication.create!(application_id: @app.id, pet_id: fido.id)
      petapp2 = PetApplication.create!(application_id: @app.id, pet_id: santa.id)
      visit "/applications/#{@app.id}"
      click_link 'Fido'
      expect(current_path).to eq("/pets/#{fido.id}")
    end
    it 'has app\'s status' do
      visit "/applications/#{@app.id}"
      expect(page).to have_content(@app.status)
    end
  end

  describe 'Searching for pets' do
    before(:each) do
      @app = Application.create!(name: 'John Smith',
                                 address: '123 Fake Street',
                                 city: 'Springfield',
                                 state: 'IL',
                                 zipcode: 12_345,
                                 description: 'I like dogs.',
                                 status: 'In Progress')
    end
    # 4. Searching for Pets for an Application

    # As a visitor
    # When I visit an application's show page
    # And that application has not been submitted,
    # Then I see a section on the page to "Add a Pet to this Application"
    # In that section I see an input where I can search for Pets by name
    # When I fill in this field with a Pet's name
    # And I click submit,
    # Then I am taken back to the application show page
    # And under the search bar I see any Pet whose name matches my search
    it 'has a section \'Add a Pet to this Application\' when not yet submitted' do
      shelter = Shelter.create!(
        foster_program: true,
        name: 'Dog house',
        city: 'Springfield',
        rank: 1
      )
      fido = shelter.pets.create!(
        adoptable: true,
        age: 1,
        breed: 'weiner',
        name: 'Fido'
      )
      visit "/applications/#{@app.id}"
      expect(@app.status).to eq('In Progress')
      expect(page).to have_content('Add a Pet to this Application')
      expect(page).to have_field('pet_name')
      fill_in 'pet_name', with: 'Fido'
      click_on 'Submit'
      expect(current_path).to eq("/applications/#{@app.id}")
      expect(page).to have_content('Fido')
    end
  end
end
