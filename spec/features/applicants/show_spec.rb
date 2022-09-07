require 'rails_helper'

RSpec.describe 'the applicants show' do
  before :each do
    @shelter = Shelter.create!(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    @applicant = Applicant.create!(first_name: 'John', last_name: 'Smith', street_address: '123 Fake Street', city: 'Boulder',
      state: 'CO', zip: 80305, description: "I'm awesome", status: 'Pending')
    @applicant_1 = Applicant.create!(first_name: 'Jimmy', last_name: 'Dough', street_address: '567 Fake Street', city: 'Denver',
      state: 'CO', zip: 80205, description: "I'm kinda awesome", status: 'Approved')
    @applicant_2 = Applicant.create!(first_name: 'Johnny', last_name: 'Johnson', street_address: '17 Psuedo Street', city: 'Breckenridge',
      state: 'CO', zip: 80424, description: "I'm not awesome", status: 'In Progress')
    @pet = @applicant.pets.create!(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: @shelter.id)
    @pet_1 = @applicant_1.pets.create!(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: false, shelter_id: @shelter.id)
    @pet_2 = @applicant.pets.create!(name: 'Jake', age: 5, breed: 'Pug', adoptable: true, shelter_id: @shelter.id)
    @applicant_1.pets << @pet
    @applicant_2.pets << @pet_2
  end

  describe 'applicant info' do
    it "shows the name of the applicant" do
      visit "/applicants/#{@applicant.id}"

      expect(page).to have_content(@applicant.first_name)
      expect(page).to have_content(@applicant.last_name)
      expect(page).to_not have_content(@applicant_1.street_address)
      expect(page).to_not have_content(@applicant_2.first_name)

      visit "/applicants/#{@applicant_1.id}"

      expect(page).to have_content(@applicant_1.street_address)
      expect(page).to have_content(@applicant_1.description)
      expect(page).to_not have_content(@applicant_2.first_name)

    end

    it 'shows the full Address of the Applicant including street address, city, state, and zip code' do
      visit "/applicants/#{@applicant.id}"

      expect(page).to have_content(@applicant.street_address)
      expect(page).to have_content(@applicant.city)
      expect(page).to have_content(@applicant.state)
      expect(page).to have_content(@applicant.zip)
      expect(page).to_not have_content(@applicant_1.city)

      visit "/applicants/#{@applicant_1.id}"

      expect(page).to have_content(@applicant_1.street_address)
      expect(page).to have_content(@applicant_1.city)
      expect(page).to have_content(@applicant_1.state)
      expect(page).to have_content(@applicant_1.zip)
      expect(page).to_not have_content(@applicant_2.zip)
    end

    it 'shows the description of why the applicant says they would be a good home for this pets' do
      visit "/applicants/#{@applicant.id}"

      expect(page).to have_content(@applicant.description)
      expect(page).to_not have_content(@applicant_1.description)

      visit "/applicants/#{@applicant_2.id}"

      expect(page).to have_content(@applicant_2.description)
      expect(page).to_not have_content(@applicant.description)
    end

    it 'names of all pets that this application is for (all names of pets should be links to their show page)' do
      visit "/applicants/#{@applicant.id}"

      within("#applicant-#{@applicant.id}") do
        expect(page).to have_content(@pet.name)
        expect(page).to_not have_content(@pet_1.name)
        expect(page).to have_content(@pet_2.name)
        expect(find_link("#{@pet.name}").visible?).to be true
        expect(find_link("#{@pet_2.name}").visible?).to be true
      end

      click_link "#{@pet_2.name}"
      expect(current_path).to eq("/pets/#{@pet_2.id}")

      visit "/applicants/#{@applicant_1.id}"

      within("#applicant-#{@applicant_1.id}") do
        expect(page).to have_content(@pet.name)
        expect(page).to have_content(@pet_1.name)
        expect(page).to_not have_content(@pet_2.name)
        expect(find_link("#{@pet.name}").visible?).to be true
        expect(find_link("#{@pet_1.name}").visible?).to be true
      end

      click_link "#{@pet.name}"
      expect(current_path).to eq("/pets/#{@pet.id}")

    end

    it 'The Applications status, either In Progress, Pending, Accepted, or Rejected' do
      visit "/applicants/#{@applicant.id}"

      expect(page).to have_content(@applicant.status)
      expect(page).to_not have_content(@applicant_1.status)
      expect(page).to_not have_content(@applicant_2.status)
    end
  end

  describe 'pet search' do
    before :each do
      @applicant = Applicant.create!(first_name: 'Jimmy', last_name: 'Dough', street_address: '567 Fake Street',
        city: 'Denver', state: 'CO', zip: 80205, description: "I'm awesome", status: 'In Progress')
      @applicant_1 = Applicant.create!(first_name: 'Johnny', last_name: 'Dough', street_address: '57 Fake Street', city: 'Denver',
          state: 'CO', zip: 80205, description: "I'm kinda awesome", status: 'Pending')
      @applicant_2 = Applicant.create!(first_name: 'Johnny', last_name: 'Johnson', street_address: '17 Psuedo Street', city: 'Denver',
          state: 'CO', zip: 80205, description: "I'm not awesome", status: 'In Progress')
      @pet_3 = Pet.create!(name: 'Frank', age: 10,
        breed: 'Lab', adoptable: true, shelter_id: @shelter.id)
      @pet_4 = Pet.create!(name: 'Gizmo', age: 8,
        breed: 'Bulldog', adoptable: true, shelter_id: @shelter.id)
      @pet_5 = Pet.create!(name: 'frappacino', age: 2,
        breed: 'Poodle', adoptable: true, shelter_id: @shelter.id)
      @pet_6 = Pet.create!(name: 'MR FROSTY', age: 3,
        breed: 'Mut', adoptable: true, shelter_id: @shelter.id)
    end

    it 'I see a section on the page to add a pet to this application' do
      visit "/applicants/#{@applicant.id}"

      expect(page).to have_content("Add a Pet to This Application")

      visit "/applicants/#{@applicant_2.id}"

      expect(page).to have_content("Add a Pet to This Application")
    end


    it 'In that section I see an input where I can search for Pets by name' do
      visit "/applicants/#{@applicant.id}"

      expect(page).to have_content("Search pet's name")
      expect(page).to have_button("Search")

      visit "/applicants/#{@applicant_2.id}"

      expect(page).to have_content("Search pet's name")
      expect(page).to have_button("Search")
    end

    it 'I fill in the field and click submit then I see the Pet I searched' do
      visit "/applicants/#{@applicant.id}"

      fill_in "Search pet's name", with: "Frank"
      click_on("Search")

      expect(current_path).to eq("/applicants/#{@applicant.id}")
      expect(page).to have_content(@pet_3.name)
      expect(page).to_not have_content(@pet_4.name)
    end

    it "When I search for a Pet by name I see the names Pets that match my search, next to each Pet's name I see a button to 'Adopt this Pet'" do
      visit "/applicants/#{@applicant.id}"

      fill_in "Search pet's name", with: "Frank"
      click_on("Search")

      expect(page).to have_button('Adopt this Pet')
      expect(find_button({value:'Adopt this Pet', id:"#{@pet_3.id}"}).visible?).to be true

    end

    it "When I click one of these 'Adopt this Pet' buttons I am taken back to the application show page and I see the Pet I want to adopt listed on this application" do

     visit "/applicants/#{@applicant.id}"

      fill_in "Search pet's name", with: "Frank"
      click_on("Search")
      click_on("Adopt this Pet")

      expect(current_path).to eq("/applicants/#{@applicant.id}")
      expect(page).to have_content(@pet_3.name)
      expect(find_link("#{@pet_3.name}").visible?).to be true
    end

    it "Before I have added one or more pets to the application, I do not see a section to submit my application." do

      visit "/applicants/#{@applicant.id}"

      expect(page).to_not have_button('Apply for these Pets')

      visit "/applicants/#{@applicant_2.id}"

      expect(page).to_not have_button('Apply for these Pets')

    end

    it "Once I have added one or more pets to the application, then I see a section to submit my application and in that section I see an input to enter why I would make a good owner for these pet(s)" do

      visit "/applicants/#{@applicant.id}"

      fill_in "Search pet's name", with: "Frank"
      click_on("Search")
      click_on("Adopt this Pet")

      expect(page).to have_button('Apply for these Pets')
      expect(current_path).to eq("/applicants/#{@applicant.id}")
      expect(page.has_field? "description").to be true

      visit "/applicants/#{@applicant_2.id}"

      fill_in "Search pet's name", with: "Frank"
      click_on("Search")
      click_on("Adopt this Pet")

      expect(page).to have_button('Apply for these Pets')
      expect(current_path).to eq("/applicants/#{@applicant_2.id}")
      expect(page.has_field? "description").to be true

    end

    it "When I fill in that input and I click a button to submit this application I am taken back to the application's show page, and I see an indicator that the application is 'Pending', and I see all the pets that I want to adopt. I do not see a section to add more pets to this application" do

      visit "/applicants/#{@applicant.id}"

      fill_in "Search pet's name", with: "Frank"
      click_on("Search")
      click_on("Adopt this Pet")

      fill_in "description", with: "I love cuddles with Frank"
      click_on("Apply for these Pets")

      expect(page).to have_content("Pending")
      expect(page).to_not have_content("In Progress")
      expect(page).to have_content(@pet_3.name)
      expect(page).to_not have_content(@pet_2.name)
      expect(find_link("#{@pet_3.name}").visible?).to be true

      expect(page).to_not have_content("Search pet's name")
      expect(page).to_not have_button("Search")
      expect(page).to_not have_button('Apply for these Pets')

    end

    it "If I have not added any pets to the application, then I do not see a section to submit my application" do

      visit "/applicants/#{@applicant.id}"

      expect(page).to_not have_button('Apply for these Pets')

      visit "/applicants/#{@applicant_2.id}"

      expect(page).to_not have_button('Apply for these Pets')
    end

    it 'I search for Pets by name and I see any pet whose name PARTIALLY matches my search' do

      visit "/applicants/#{@applicant.id}"

      fill_in "Search pet's name", with: "Fra"
      click_on("Search")

      expect(current_path).to eq("/applicants/#{@applicant.id}")
      expect(page).to have_content(@pet_3.name)
      expect(page).to have_content(@pet_5.name)
      expect(page).to_not have_content(@pet_4.name)

      visit "/applicants/#{@applicant_2.id}"

      fill_in "Search pet's name", with: "Fra"
      click_on("Search")

      expect(current_path).to eq("/applicants/#{@applicant_2.id}")
      expect(page).to have_content(@pet_3.name)
      expect(page).to have_content(@pet_5.name)
      expect(page).to_not have_content(@pet_4.name)
    end

    it 'I search for Pets by name and my search is case insensitive' do

      visit "/applicants/#{@applicant.id}"

      fill_in "Search pet's name", with: "fR"
      click_on("Search")

      expect(current_path).to eq("/applicants/#{@applicant.id}")
      expect(page).to have_content(@pet_3.name)
      expect(page).to have_content(@pet_5.name)
      expect(page).to have_content(@pet_6.name)
      expect(page).to_not have_content(@pet_4.name)

      visit "/applicants/#{@applicant_2.id}"

      fill_in "Search pet's name", with: "fR"
      click_on("Search")

      expect(current_path).to eq("/applicants/#{@applicant_2.id}")
      expect(page).to have_content(@pet_3.name)
      expect(page).to have_content(@pet_5.name)
      expect(page).to have_content(@pet_6.name)
      expect(page).to_not have_content(@pet_4.name)
    end
  end
end
