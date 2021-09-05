require 'rails_helper'

RSpec.describe 'the app show page' do
  before(:each) do
    @shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @pet_1 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: @shelter.id)
    @pet_2 = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: @shelter.id)

    @app_1 = Application.create!(name: "Cindy Lou Who", address: "123 Some Street", city: "Whoville", state: "WI", zip: "12345", description: "I'm a who for crying out loud.")
    @app_pet_1 = ApplicationPet.create!(pet: @pet_1, application: @app_1)

    @app_2 = Application.create!(name: "The Grinch", address: "2376 Mountaintop Drive", city: "Whoville", state: "WI", zip: "12345")
    @app_pet_2 = ApplicationPet.create!(pet: @pet_1, application: @app_2)
    @app_pet_3 = ApplicationPet.create!(pet: @pet_2, application: @app_2)

    @app_3 = Application.create!(name: "Horton", address: "7874 Hickory Lane", city: "Whoknows", state: "MA", zip: "48943")
  end

  it 'shows an applicants personal info' do
    visit "/applications/#{@app_1.id}"

    expect(page).to have_content("Applicant Name: Cindy Lou Who")
    expect(page).to have_content("Address: 123 Some Street, Whoville, WI 12345")
    expect(page).to have_content("Description: I'm a who for crying out loud.")
    expect(page).to have_content("Pet(s) Applying For:\n#{@pet_1.name}")
    expect(page).to have_content("Application Status: In Progress")
  end

  it 'has a link to each pet applying for' do
    visit "/applications/#{@app_1.id}"

    click_link("Lucille Bald")
    expect(current_path).to eq("/pets/#{@pet_1.id}")
  end

  it 'can have multiple links' do
    visit "/applications/#{@app_2.id}"

    expect(page).to have_content("Pet(s) Applying For:\n#{@pet_1.name} #{@pet_2.name}")

    click_link("Lucille Bald")
    expect(current_path).to eq("/pets/#{@pet_1.id}")

    visit "/applications/#{@app_2.id}"

    click_link("Lobster")
    expect(current_path).to eq("/pets/#{@pet_2.id}")
  end

  context 'app not submitted' do
    it 'has a section to add pet' do
      visit "/applications/#{@app_3.id}"

      expect(page).to have_content("Add a Pet to this Application")

      fill_in('Search', with: "Lucille")
      click_on("Search")

      expect(page).to     have_content(@pet_1.name)
      expect(page).to_not have_content(@pet_2.name)

      fill_in('Search', with: "l")
      click_on("Search")

      within "#pet-#{@pet_1.id}" do
        expect(page).to have_content(@pet_1.name)
      end

      within "#pet-#{@pet_2.id}" do
        expect(page).to have_content(@pet_2.name)
      end
    end

    it 'has a button to adopt each pet added' do
      visit "/applications/#{@app_3.id}"

      fill_in('Search', with: "l")
      click_on("Search")

      within "#pet-#{@pet_1.id}" do
        click_button("Adopt this Pet")
      end

      expect(current_path).to eq("/applications/#{@app_3.id}")
      expect(page).to have_content("Pet(s) Applying For:\n#{@pet_1.name}")

      fill_in('Search', with: "l")
      click_on("Search")

      within "#pet-#{@pet_2.id}" do
        click_button("Adopt this Pet")
      end

      expect(current_path).to eq("/applications/#{@app_3.id}")
      expect(page).to have_content("Pet(s) Applying For:\n#{@pet_1.name} #{@pet_2.name}")
    end

    it 'cannot add same pet to app twice' do
      visit "/applications/#{@app_3.id}"

      fill_in('Search', with: "l")
      click_on("Search")

      within "#pet-#{@pet_1.id}" do
        click_button("Adopt this Pet")
      end

      fill_in('Search', with: "l")
      click_on("Search")

      within "#pet-#{@pet_1.id}" do
        click_button("Adopt this Pet")
      end

      expect(page).to     have_content("Error: Pet already added.")
      expect(page).to_not have_content("Pet(s) Applying For:\n#{@pet_1.name} #{@pet_1.name}")
    end

    it 'has a section to submit the app' do
      visit "/applications/#{@app_2.id}"

      within "#submit-app" do
        fill_in("description", with: "I don't need a reason. I'm the Grinch.")
        click_button("Submit Application")
      end

      expect(current_path).to eq("/applications/#{@app_2.id}")

      expect(page).to     have_content("Application Status: Pending")
      expect(page).to     have_content("Pet(s) Applying For:\n#{@pet_1.name} #{@pet_2.name}")
      expect(page).to_not have_content("Search")
    end

    it 'does not have a Submit button when no pets are added' do
      visit "/applications/#{@app_3.id}"

      expect(page).to_not have_button("Submit Application")
    end
  end

  context 'application submitted' do
    it 'does not have a submit button' do
      visit "/applications/#{@app_2.id}"

      expect(page).to have_button("Submit Application")
      save_and_open_page

      within "#submit-app" do
        fill_in("description", with: "I don't need a reason. I'm the Grinch.")
        click_button("Submit Application")
      end

      expect(page).to_not have_button("Submit Application")
    end
  end
end
