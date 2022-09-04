require 'rails_helper'

RSpec.describe 'applicant show page' do

  # User Story 2
  # As a visitor
  # When I visit an applications show page
  # Then I can see the following:

  # Name of the Applicant
  # Full Address of the Applicant including street address, city, state, and zip code
  # Description of why the applicant says they'd be a good home for this pet(s)
  # names of all pets that this application is for (all names of pets should be links to their show page)
  # The Application's status, either "In Progress", "Pending", "Accepted", or "Rejected"

  describe 'When I visit an applications show page I see the following' do
    before :each do
      @shelter = Shelter.create!(foster_program: true, name: "Pet Friends of Kansas", city: "Topeka", rank: 8)
      @dog1 = @shelter.pets.create!(adoptable: true, age: 5, breed: 'Poodle', name: 'Fiona')
      @dog2 = @shelter.pets.create!(adoptable: true, age: 2, breed: 'Terrier', name: 'Rosco')
      @cat1 = @shelter.pets.create!(adoptable: true, age: 7, breed: 'Persian', name: 'SlimJim')
      @cat2 = @shelter.pets.create!(adoptable: true, age: 1, breed: 'Tabby', name: 'Catmobile')
      @app1 = Applicant.create!(first_name: 'Sally', last_name: 'Field', street_address: '115 Oakview Avenue', city: 'Topeka', state: 'Kansas', zipcode: '65119', description: 'I dislike every bird, therefore I require many cats.', status: 'In Progress')
      @app2 = Applicant.create!(first_name: 'Burt', last_name: 'Reynolds', street_address: '400 Pine Drive', city: 'Bend', state: 'Oregon', zipcode: '91123', description: 'I find tiny barking dogs to be extremely soothing and it is important to me that my neighbors know that.', status: 'In Progress')
    end
    it 'I see name of the Applicant and their full address' do
      visit "/applicants/#{@app1.id}"

      expect(page).to have_content(@app1.first_name)
      expect(page).to have_content(@app1.last_name)
      expect(page).to have_content(@app1.street_address)
      expect(page).to have_content(@app1.city)
      expect(page).to have_content(@app1.state)
      expect(page).to have_content(@app1.zipcode)

      visit "/applicants/#{@app2.id}"

      expect(page).to have_content(@app2.first_name)
      expect(page).to have_content(@app2.last_name)
      expect(page).to have_content(@app2.street_address)
      expect(page).to have_content(@app2.city)
      expect(page).to have_content(@app2.state)
      expect(page).to have_content(@app2.zipcode)
    end

    it 'I see the Description of why the applicant says theyd be a good home for this pets' do
      visit "/applicants/#{@app1.id}"

      expect(page).to have_content(@app1.description)

      visit "/applicants/#{@app2.id}"

      expect(page).to have_content(@app2.description)
    end

    it 'I see the names of all pets that this application is for (all names of pets should be links to their show page' do
      @app1.pets << @cat1
      @app1.pets << @cat2
      @app2.pets << @dog1
      @app2.pets << @dog2

      visit "/applicants/#{@app1.id}"

      expect(page).to have_content(@cat1.name)
      expect(page).to have_content(@cat2.name)

      expect(find_link("#{@cat1.name}")[:href].should == "/pets/#{@cat1.id}")
      expect(find_link("#{@cat2.name}")[:href].should == "/pets/#{@cat2.id}")

      click_on "#{@cat1.name}"

      expect(current_path).to eq("/pets/#{@cat1.id}")

      visit "/applicants/#{@app2.id}"

      expect(page).to have_content(@dog1.name)
      expect(page).to have_content(@dog2.name)

      expect(find_link("#{@dog1.name}")[:href].should == "/pets/#{@dog1.id}")
      expect(find_link("#{@dog2.name}")[:href].should == "/pets/#{@dog2.id}")

      click_on "#{@dog1.name}"

      expect(current_path).to eq("/pets/#{@dog1.id}")
    end

    it 'I see the Applications status, either "In Progress", "Pending", "Accepted", or "Rejected' do
      visit "/applicants/#{@app1.id}"

      expect(page).to have_content(@app1.status)

      visit "/applicants/#{@app2.id}"

      expect(page).to have_content(@app2.status)
    end
  end

  # User Story 10 

  # As a visitor
  # When I visit an application's show page
  # And that application has not been submitted,
  # Then I see a section on the page to "Add a Pet to this Application"
  # In that section I see an input where I can search for Pets by name
  # When I fill in this field with a Pet's name
  # And I click submit,
  # Then I am taken back to the application show page
  # And under the search bar I see any Pet whose name matches my search

  describe 'When I visit an applications show page and the application has not been submitted' do
    before :each do
      @shelter = Shelter.create!(foster_program: true, name: "Pet Friends of Kansas", city: "Topeka", rank: 8)
      @cat1 = @shelter.pets.create!(adoptable: true, age: 7, breed: 'Persian', name: 'SlimJim')
      @cat2 = @shelter.pets.create!(adoptable: true, age: 1, breed: 'Tabby', name: 'Catmobile')
      @app = Applicant.create!(first_name: 'Sally', last_name: 'Field', street_address: '115 Oakview Avenue', city: 'Topeka', state: 'Kansas', zipcode: '65119', description: 'I dislike every bird, therefore I require many cats.', status: 'In Progress')
    end

    it 'Then I see a section on the page to "Add a Pet to this Application"' do
      visit "/applicants/#{@app.id}"
      
      expect(has_field?).to be(true)
      expect(have_field('Add a Pet to this Application'))
    end

    it 'when I fill in the field and search for a pet, the pet name appears under the search bar' do
      visit "/applicants/#{@app.id}"

      fill_in 'pet_search', with: "SlimJim"

      click_on 'Submit'

      expect(current_path).to eq("/applicants/#{@app.id}")

      expect(page).to have_content(@cat1.name)
    end
  end

  # User Story 6

  # As a visitor
  # When I visit an application's show page
  # And I search for a Pet by name
  # And I see the names Pets that match my search
  # Then next to each Pet's name I see a button to "Adopt this Pet"
  # When I click one of these buttons
  # Then I am taken back to the application show page
  # And I see the Pet I want to adopt listed on this application

  describe 'When I visit applications show page and search for pet' do
    before :each do
      @shelter = Shelter.create!(foster_program: true, name: "Pet Friends of Kansas", city: "Topeka", rank: 8)
      @cat1 = @shelter.pets.create!(adoptable: true, age: 7, breed: 'Persian', name: 'SlimJim')
      @cat2 = @shelter.pets.create!(adoptable: true, age: 1, breed: 'Tabby', name: 'Catmobile')
      @app = Applicant.create!(first_name: 'Sally', last_name: 'Field', street_address: '115 Oakview Avenue', city: 'Topeka', state: 'Kansas', zipcode: '65119', description: 'I dislike every bird, therefore I require many cats.', status: 'In Progress')
    end

    it 'And I see the names Pets that match my search' do
      visit "/applicants/#{@app.id}"

      fill_in 'pet_search', with: "#{@cat2.name}"

      click_on 'Submit'

      expect(current_path).to eq("/applicants/#{@app.id}")

      expect(page).to have_content(@cat2.name)
    end

    it 'Then next to each Pets name I see a button to "Adopt this Pet"' do
      visit "/applicants/#{@app.id}"

      fill_in 'pet_search', with: "#{@cat2.name}"

      click_on 'Submit'

      expect(page).to have_button('Adopt this Pet')
    end

    it 'When I click adopt pet I am taking back to show page and that pet is now listed on application' do
      visit "/applicants/#{@app.id}"

      fill_in 'pet_search', with: "#{@cat2.name}"

      click_on 'Submit'

      click_button 'Adopt this Pet'

      expect(current_path).to eq("/applicants/#{@app.id}")
      save_and_open_page
      expect(page).to have_content(@cat2.name)
    end
  end
end