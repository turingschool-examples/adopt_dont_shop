require 'rails_helper'

describe 'app show page' do
  before(:each) do
    @app = create(:application, description: 'I like dogs.', status: 'In Progress')
    @shelter = create(:shelter)
    @pet_1 = create(:pet, shelter_id: @shelter.id)
    @pet_2 = create(:pet, shelter_id: @shelter.id)
    @fido = @shelter.pets.create(adoptable: true, age: 1, breed: 'weiner', name: 'Fido')
    @fido2 = @shelter.pets.create(adoptable: true, age: 2, breed: 'something else', name: 'Fido')
    @fidilly = @shelter.pets.create( adoptable: true, age: 3, breed: 'doxon', name: 'Fidilly')
  end
  
  describe 'app details' do
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
    # 4. Searching for Pets for an Application
    it 'has a section \'Add a Pet to this Application\' when not yet submitted' do
      visit "/applications/#{@app.id}"
      expect(@app.status).to eq("In Progress")
      expect(page).to_not have_content(@pet_1.name)
      expect(page).to have_content('Add a Pet to this Application')
      expect(page).to have_field('pet_name')
      
      fill_in 'pet_name', with: @pet_1.name
      click_on 'Submit'
      expect(current_path).to eq("/applications/#{@app.id}")
      expect(page).to have_content(@pet_1.name)
    end

    it 'can populate multiple pets' do
      visit "/applications/#{@app.id}"
      expect(@app.status).to eq('In Progress')
      expect(page).to_not have_content('Fido')
      expect(page).to have_content('Add a Pet to this Application')
      expect(page).to have_field('pet_name')

      fill_in 'pet_name', with: 'Fido'
      click_on 'Submit'
      expect(current_path).to eq("/applications/#{@app.id}")
      expect(page).to have_link 'Fido', href: "/pets/#{@fido.id}"
      expect(page).to have_link 'Fido', href: "/pets/#{@fido2.id}"

      within("##{@fido.id}") do
        click_link 'Fido'
        expect(current_path).to eq("/pets/#{@fido.id}")
      end
    end

    it 'has a button to "Adopt this Pet", that adopts the pet' do
      visit "/applications/#{@app.id}"
      fill_in 'pet_name', with: 'Fido'
      click_on 'Submit'
      expect(page).to have_button('Adopt this Pet')

      click_on 'Adopt this Pet' # create within block to resolve capybara::ambiguous
      expect(current_path).to eq("/applications/#{@app.id}")
      expect(page).to have_content("Pets Applying for: #{fido.name}")
    end
  end

  describe 'submitting an application' do
    # 6. Submit an Application
    # 7. No Pets on an Application
    it 'does not have a button to submit when I have no pets on the application' do
      visit "/applications/#{@app.id}"
      expect(page).to_not have_content('Why would you make a good owner?')
      expect(page).to_not have_button('Submit Application')
    end

    it 'has a button to submit when I have pets on the application' do
      petapp1 = PetApplication.create!(application_id: @app.id, pet_id: @pet_1.id)
      petapp2 = PetApplication.create!(application_id: @app.id, pet_id: @pet_2.id)
      visit "/applications/#{@app.id}"
      expect(page).to have_button('Submit Application')

      fill_in 'description', with: 'I like dogs and cats'
      click_button 'Submit Application'
      expect(current_path).to eq "/applications/#{@app.id}"
      expect(page).to have_content('Status: Pending')
    end

    describe 'User Story 8 (#10), partial matches' do
      # 8. Partial Matches for Pet Names
      it 'returns partial matches for pet names' do
        visit "/applications/#{@app.id}"
        fill_in 'pet_name', with: 'Fid'
        click_on 'Submit'

        expect(page).to have_content(@fido.name)
        expect(page).to have_content(@fidilly.name)
      end
    end

    describe 'case insensitive matches for pet names' do
      # 9. Case Insensitive Matches for Pet Names
      it 'does not care about case' do
        visit "/applications/#{@app.id}"
        fill_in 'pet_name', with: 'fid'
        click_on 'Submit'

        expect(page).to have_content(@fido.name)
        visit "/applications/#{@app.id}"
        expect(page).to_not have_content(@fido.name)

        fill_in 'pet_name', with: 'ID'
        click_on 'Submit'
        expect(page).to have_content(@fido.name)
      end
    end
  end
end