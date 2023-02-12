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
      expect(page).to_not have_content('Fido')
      expect(page).to have_content('Add a Pet to this Application')
      expect(page).to have_field('pet_name')
      fill_in 'pet_name', with: 'Fido'
      click_on 'Submit'
      expect(current_path).to eq("/applications/#{@app.id}")
      expect(page).to have_content(fido.name)
    end

    it 'can populate multiple pets' do
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
      fido2 = shelter.pets.create!(
        adoptable: true,
        age: 3,
        breed: 'schnauzer',
        name: 'Fido'
      )
      visit "/applications/#{@app.id}"
      expect(@app.status).to eq('In Progress')
      expect(page).to_not have_content('Fido')
      expect(page).to have_content('Add a Pet to this Application')
      expect(page).to have_field('pet_name')
      fill_in 'pet_name', with: 'Fido'
      click_on 'Submit'
      expect(current_path).to eq("/applications/#{@app.id}")
      expect(page).to have_link 'Fido', href: "/pets/#{fido.id}"
      expect(page).to have_link 'Fido', href: "/pets/#{fido2.id}"
    end

    it 'has a button to "Adopt this Pet", that adopts the pet' do
      # 5. Add a Pet to an Application
      # As a visitor
      # When I visit an application's show page
      # And I search for a Pet by name
      # And I see the names Pets that match my search
      # Then next to each Pet's name I see a button to "Adopt this Pet"
      # When I click one of these buttons
      # Then I am taken back to the application show page
      # And I see the Pet I want to adopt listed on this application
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
      fill_in 'pet_name', with: 'Fido'
      click_on 'Submit'
      expect(page).to have_button('Adopt this Pet')
      click_on 'Adopt this Pet'
      expect(current_path).to eq("/applications/#{@app.id}")
      expect(page).to have_content("Pets Applying for: #{fido.name}")
    end
  end

  describe 'submitting an application' do
    # 6. Submit an Application

    # As a visitor
    # When I visit an application's show page
    # And I have added one or more pets to the application
    # Then I see a section to submit my application
    # And in that section I see an input to enter why I would make a good owner for these pet(s)
    # When I fill in that input
    # And I click a button to submit this application
    # Then I am taken back to the application's show page
    # And I see an indicator that the application is "Pending"
    # And I see all the pets that I want to adopt
    # And I do not see a section to add more pets to this application

    # 7. No Pets on an Application

    # As a visitor
    # When I visit an application's show page
    # And I have not added any pets to the application
    # Then I do not see a section to submit my application

    before(:each) do
      @app = Application.create!(name: 'John Smith',
                                 address: '123 Fake Street',
                                 city: 'Springfield',
                                 state: 'IL',
                                 zipcode: 12_345,
                                 description: 'I like dogs.',
                                 status: 'In Progress')
    end
    it 'does not have a button to submit when I have no pets on the application' do
      visit "/applications/#{@app.id}"
      expect(page).to_not have_content('Submit Application')
    end

    it 'has a button to submit when I have pets on the application' do
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
      expect(page).to have_button('Submit Application')
      fill_in 'description', with: 'I like dogs and cats'
      click_button 'Submit Application'
      expect(current_path).to eq "/applications/#{@app.id}"
      expect(page).to have_content('Status: Pending')
    end

    describe 'User Story 8 (#10), partial matches' do
      # 8. Partial Matches for Pet Names

      # As a visitor
      # When I visit an application show page
      # And I search for Pets by name
      # Then I see any pet whose name PARTIALLY matches my search
      # For example, if I search for "fluff", my search would match pets with names "fluffy", "fluff", and "mr. fluff"
      it 'returns partial matches for pet names' do
        # Solution can be created using pets controller and application_record
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
        fidilly = shelter.pets.create!(
          adoptable: true,
          age: 1,
          breed: 'doxon',
          name: 'Fidilly'
        )

        visit "/applications/#{@app.id}"
        fill_in 'pet_name', with: 'Fid'
        click_on 'Submit'

        expect(page).to have_content(fido.name)
        expect(page).to have_content(fidilly.name)
      end
    end

    describe 'case insensitve matches for pet names' do
      # [ ] done

      # 9. Case Insensitive Matches for Pet Names
      
      # As a visitor
      # When I visit an application show page
      # And I search for Pets by name
      # Then my search is case insensitive
      # For example, if I search for "fluff", my search would match pets with names "Fluffy", "FLUFF", and "Mr. FlUfF"
      it 'does not care about case' do
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
        fill_in 'pet_name', with: 'fid'
        click_on 'Submit'

        expect(page).to have_content(fido.name)
        visit "/applications/#{@app.id}"
        expect(page).to_not have_content(fido.name)
        fill_in 'pet_name', with: 'ID'
        click_on 'Submit'
        expect(page).to have_content(fido.name)
      end
    end
  end
end
