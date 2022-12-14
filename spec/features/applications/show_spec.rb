require 'rails_helper'

RSpec.describe "Application Show Page" do
  before :each do
    @shelter_1 = Shelter.create!(
      foster_program: true,
      name: "Healthy Paws",
      city: "Denver",
      rank: 3
    )

    @application_1 = Application.create!(
      name: "Bob",
      street_address: "123 Leaf Street",
      city: "Denver",
      state: "CO",
      zip_code: 80020
    )

    @pet_1 = Pet.create!(
      name: "Pepper",
      adoptable: true,
      age: 4,
      breed: "Pitbull",
      shelter_id: @shelter_1.id
    )

    @pet_2 = Pet.create!(
      name: "Pepperoni",
      adoptable: true,
      age: 2,
      breed: "Corgi",
      shelter_id: @shelter_1.id
    )

    @pet_3 = Pet.create!(
      name: "Lemonpop",
      adoptable: true,
      age: 4,
      breed: "Pitbull",
      shelter_id: @shelter_1.id
    )
  end

  describe "User Story 1" do
    describe "User visits '/applications/:id'" do
      it 'has application attributes' do
        pet_1 = @application_1.pets.create!(
          name: "Pepper",
          adoptable: true,
          age: 4,
          breed: "Pitbull",
          shelter_id: @shelter_1.id
        )
          
        pet_2 = @application_1.pets.create!(
          name: "Daisy",
          adoptable: true,
          age: 14,
          breed: "Beagle",
          shelter_id: @shelter_1.id
        )

        visit "/applications/#{@application_1.id}"
        
        expect(page).to have_content(@application_1.name)
        expect(page).to have_content(@application_1.full_address)
        expect(page).to have_content(pet_1.name)
        expect(page).to have_content(@application_1.status)

        click_link "Pepper"

        expect(current_path).to eq("/pets/#{pet_1.id}")
      end
    end
  end

  describe "User Story 4" do
    describe "User application is in progress" do
      it 'has a section to search for a pet' do
        visit "/applications/#{@application_1.id}"

        expect(page).to have_content("Add a Pet to this Application")
        expect(page).to have_field(:search)
        expect(page).to have_button("Search For Pet!")
      end

      it 'returns list of pets with exact name match' do
        visit "/applications/#{@application_1.id}"

        fill_in(:search, with: "Pepper")
        click_button("Search For Pet!")

        expect(page).to have_link("Pepper", href: "/pets/#{@pet_1.id}")
      end
    end
  end

  describe "User story 5" do
    describe "Search a pet by name" do
      it "has a button 'Adopt this Pet' next to the pet's name" do   
        visit "/applications/#{@application_1.id}"

        fill_in(:search, with: "Pepper")
        click_button("Search For Pet!")

        expect(page).to have_button("Adopt #{@pet_1.name}!")
        
        click_button("Adopt #{@pet_1.name}!")
        
        within("#application_pets") do
          expect(page).to have_content("#{@pet_1.name}")
        end

        expect(current_path).to eq("/applications/#{@application_1.id}")
      end
    end
  end

  describe "User Story 6" do
    describe "User has added pets to application" do
      it 'now has a section to enter good owner description' do
        pet_1 = @application_1.pets.create!(
          name: "Pepper",
          adoptable: true,
          age: 4,
          breed: "Pitbull",
          shelter_id: @shelter_1.id
        )

        visit "/applications/#{@application_1.id}"

        expect(page).to have_field(:description)
        expect(page).to have_button("Submit Application")

        fill_in(:description, with: "I work from home")
        click_button("Submit Application")

        expect(current_path).to eq("/applications/#{@application_1.id}")
        expect(page).to have_content("I work from home")
        expect(page).to have_content("Pending")
        @application_1.reload
        expect(@application_1.status).to eq("Pending")
        
        within("#application_pets") do
          expect(page).to have_content("Pepper")
        end

        expect(page).to_not have_content("Add a Pet to this Application")
        expect(page).to_not have_field(:search)
        expect(page).to_not have_button("Search For Pet!")
      end
    end
  end

  describe "User Story 7" do
    describe "User hasn't added pets to the application" do
      it 'does not have the option to submit the application' do
        visit "/applications/#{@application_1.id}"

        expect(page).to_not have_field(:description)
        expect(page).to_not have_button("Submit Application")
      end
    end
  end

  describe "User Story 8" do
    describe "Partial matches" do
      it 'can see any pet whos name partially matches the search' do
        visit "/applications/#{@application_1.id}"

        expect(page).to have_field(:search)
        expect(page).to have_content("Add a Pet to this Application")
        expect(page).to have_no_content('Pepper')
        expect(current_path).to eq("/applications/#{@application_1.id}")
        
        fill_in(:search, with: 'Pep')
        click_button('Search For Pet!')
        
        expect(page).to have_content('Pepper')
        expect(page).to have_content('Pepperoni')
        expect(current_path).to eq("/applications/#{@application_1.id}")
      end
    end
  end

  describe "User story 9" do
    describe "case insensitive" do
      it 'can match pet names despite case' do
        visit "/applications/#{@application_1.id}"

        expect(page).to have_field(:search)
        expect(page).to have_content("Add a Pet to this Application")
        expect(page).to have_no_content('Pepper')
        expect(current_path).to eq("/applications/#{@application_1.id}")
        
        fill_in(:search, with: 'pEpPER')
        click_button('Search For Pet!')
        
        expect(page).to have_content('Pepper')
        expect(page).to have_content('Pepperoni')
        expect(current_path).to eq("/applications/#{@application_1.id}")
      end
    end
  end
end