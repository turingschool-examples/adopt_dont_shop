require 'rails_helper'

RSpec.describe 'the application show' do
  describe "User Story 2" do
    before(:each) do
      ApplicationPet.destroy_all
      Pet.destroy_all
      Shelter.destroy_all
      Application.destroy_all
      @shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      @pet_1 = @shelter.pets.create!(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
      @applicant_1 = @pet_1.applications.create!(name: 'Dawson', 
      street_address: '1234 example ave.', 
      city: 'Denver', 
      state: 'CO',
      zip_code: 12345, 
      reason_for_adoption: "I love dogs",
      status: "In Progress"
      )
    end
    it "shows the visitor the applicant and all of it's attributes" do
      visit "/applications/#{@applicant_1.id}"
      expect(current_path).to eq("/applications/#{@applicant_1.id}")
      expect(page).to have_content(@applicant_1.name)
      expect(page).to have_content(@applicant_1.street_address)
      expect(page).to have_content(@applicant_1.city)
      expect(page).to have_content(@applicant_1.state)
      expect(page).to have_content(@applicant_1.zip_code)
      expect(page).to have_content(@applicant_1.reason_for_adoption)
      expect(page).to have_content(@pet_1.name)
      expect(page).to have_content(@applicant_1.status)
      
      expect(page).to have_link("#{@pet_1.name}", href: "/pets/#{@pet_1.id}")
    end
  end
  
  describe "User Story 4" do
    before(:each) do
      ApplicationPet.destroy_all
      Pet.destroy_all
      Shelter.destroy_all
      Application.destroy_all
      @shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      @pet = @shelter.pets.create!(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
      @applicant_1 = @pet.applications.create!(name: 'Dawson', 
      street_address: '1234 example ave.', 
      city: 'Denver', 
      state: 'CO',
      zip_code: 12345, 
      reason_for_adoption: "I love dogs",
      status: "In Progress"
      )
    end

    it "displays a section on the show page to 'Add a Pet to this Application'" do
      visit "/applications/#{@applicant_1.id}"

      expect(page).to have_content('Add a Pet to this Application')
    end

    it "has an input where the visitor can search for Pets by name" do
      visit "/applications/#{@applicant_1.id}"

      expect(page).to have_button("Search")
    end

    it "When the visitor fills in this field with a Pet's name, And clicks submit, Then they are taken back to the application show page" do
      visit "/applications/#{@applicant_1.id}"

      fill_in("Search", with: "Mr")

      click_button("Search")

      expect(current_path).to eq("/applications/#{@applicant_1.id}")
    end

    it "Shows the visitor any Pet whose name matches my search under the search bar" do
      shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      pet_1 = Pet.create!(adoptable: true, age: 7, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: shelter.id)
      pet_2 = Pet.create!(adoptable: true, age: 3, breed: 'domestic pig', name: 'Babe', shelter_id: shelter.id)
      pet_3 = Pet.create!(adoptable: true, age: 4, breed: 'chihuahua', name: 'Elle', shelter_id: shelter.id)
      
      visit "/applications/#{@applicant_1.id}"

      fill_in 'Search', with: "Ba"
      click_on("Search")

      expect(page).to have_content(pet_1.name)
      expect(page).to have_content(pet_2.name)
      expect(page).to_not have_content(pet_3.name)
    end
  end

  describe 'User Story 5' do
    it "shows the visitor an option to 'Adopt this Pet' next to each pet's name" do
      shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      pet_1 = Pet.create!(adoptable: true, age: 7, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: shelter.id)
      applicant_1 = Application.create!(name: 'Dawson', 
      street_address: '1234 example ave.', 
      city: 'Denver', 
      state: 'CO',
      zip_code: 12345, 
      reason_for_adoption: "I love dogs",
      status: "In Progress"
      )

      ApplicationPet.create!(application: applicant_1, pet: pet_1)
      visit "/applications/#{applicant_1.id}"

      fill_in 'Search', with: "Ba"
      click_on("Search")

      expect(page).to have_button("Adopt this Pet")
    end

    it "takes the user back to the application show page" do
      shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      pet_1 = Pet.create!(adoptable: true, age: 7, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: shelter.id)
      applicant_1 = Application.create!(name: 'Dawson', 
      street_address: '1234 example ave.', 
      city: 'Denver', 
      state: 'CO',
      zip_code: 12345, 
      reason_for_adoption: "I love dogs",
      status: "In Progress"
      )

      ApplicationPet.create!(application: applicant_1, pet: pet_1)

      visit "/applications/#{applicant_1.id}"

      fill_in 'Search', with: "Ba"
      click_on("Search")

      click_button("Adopt this Pet")

      expect(current_path).to eq("/applications/#{applicant_1.id}")
    end

    it "adds the pet to the user's application" do
      shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      pet_1 = Pet.create!(adoptable: true, age: 7, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: shelter.id)
      pet_3 = Pet.create!(adoptable: true, age: 4, breed: 'chihuahua', name: 'Elle', shelter_id: shelter.id)
      applicant_1 = Application.create!(name: 'Dawson', 
      street_address: '1234 example ave.', 
      city: 'Denver', 
      state: 'CO',
      zip_code: 12345, 
      reason_for_adoption: "I love dogs",
      status: "In Progress"
      )
      
      visit "/applications/#{applicant_1.id}"
      
      fill_in 'Search', with: "Ba"
      click_on("Search")
      
      click_button("Adopt this Pet")
      expect(applicant_1.pets).to eq([pet_1])
    end
  end
  
  describe 'User Story 6' do
    it "when I visit an applications show page and add one or more pets a submit section appears" do
      shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      pet_1 = Pet.create!(adoptable: true, age: 7, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: shelter.id)
      applicant_1 = Application.create!(name: 'Dawson', 
        street_address: '1234 example ave.', 
        city: 'Denver', 
        state: 'CO',
        zip_code: 12345, 
        reason_for_adoption: "I love dogs",
        status: "In Progress"
      )
      visit "/applications/#{applicant_1.id}"
      
      expect(page).to have_no_button("Submit")
      
      fill_in 'Search', with: "Ba"
      click_on("Search")
      expect(page).to have_content(pet_1.name)
      expect(page).to have_button("Adopt this Pet")
     
      click_on 'Adopt this Pet'
      
      expect(page).to have_button("Submit Adoption Application")
      expect(page).to have_field("Why I would make a good owner for these pet(s):")
    end
    it "redirects me to the application show page and the application status is now 'pending'" do
      shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      pet_1 = Pet.create!(adoptable: true, age: 7, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: shelter.id)
      applicant_1 = Application.create!(name: 'Dawson', 
        street_address: '1234 example ave.', 
        city: 'Denver', 
        state: 'CO',
        zip_code: 12345, 
        reason_for_adoption: "I love dogs",
        status: "In Progress"
      )
      visit "/applications/#{applicant_1.id}"

        fill_in 'Search', with: "Ba"
        click_on("Search")
        
        click_on 'Adopt this Pet'

        fill_in "Why I would make a good owner for these pet(s):", with: "Because I love Them"
        click_on "Submit Adoption Application"

        expect(page).to have_current_path("/applications/#{applicant_1.id}")
        expect(page).to have_content("Pending")
        expect(page).to have_content(pet_1.name)
        expect(page).to_not have_content("Add a Pet to this Application")
    end
  end

  describe "User Story 8" do
    it "Shows the visitor any pet whose name PARTIALLY matches their search, when searching for a pet by name" do
      shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      pet_1 = Pet.create!(adoptable: true, age: 7, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: shelter.id)
      pet_2 = Pet.create!(adoptable: true, age: 3, breed: 'domestic pig', name: 'Babe', shelter_id: shelter.id)
      pet_3 = Pet.create!(adoptable: true, age: 4, breed: 'chihuahua', name: 'Elle', shelter_id: shelter.id)
      applicant_1 = Application.create!(name: 'Dawson', 
        street_address: '1234 example ave.', 
        city: 'Denver', 
        state: 'CO',
        zip_code: 12345, 
        reason_for_adoption: "I love dogs",
        status: "In Progress"
      )
      
      visit "/applications/#{applicant_1.id}"

      fill_in 'Search', with: "Ba"
      click_on("Search")

      expect(page).to have_content(pet_1.name)
      expect(page).to have_content(pet_2.name)
      expect(page).to_not have_content(pet_3.name)
    end
  end

  describe "User Story 9" do
    it "Shows the visitor any pet whose name matches their search, being case insensitive" do
      shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      pet_1 = Pet.create!(adoptable: true, age: 7, breed: 'sphynx', name: 'Bare-y Manilow', shelter_id: shelter.id)
      pet_2 = Pet.create!(adoptable: true, age: 3, breed: 'domestic pig', name: 'Babe', shelter_id: shelter.id)
      pet_3 = Pet.create!(adoptable: true, age: 4, breed: 'chihuahua', name: 'Elle', shelter_id: shelter.id)
      applicant_1 = Application.create!(name: 'Dawson', 
        street_address: '1234 example ave.', 
        city: 'Denver', 
        state: 'CO',
        zip_code: 12345, 
        reason_for_adoption: "I love dogs",
        status: "In Progress"
      )
      
      visit "/applications/#{applicant_1.id}"

      fill_in 'Search', with: "bA"
      click_on("Search")

      expect(page).to have_content(pet_1.name)
      expect(page).to have_content(pet_2.name)
      expect(page).to_not have_content(pet_3.name)

    end
  end
end