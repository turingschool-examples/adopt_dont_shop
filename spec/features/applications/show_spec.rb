require 'rails_helper'

RSpec.describe 'the application show', type: :feature do
  before :each do
    @application_1 = Application.create!(applicant_name: "Mike Sloan", street_address: "134 Willow Lane", city: "Boulder", state: "CO", zip_code: "80034", application_status: "In Progress")

    @application_2 = Application.create!(applicant_name: "Ben Spiegel", street_address: "6625 Main, Apt. 9", city: "Denver", state: "CO", zip_code: "80026", application_status: "Pending")

    @application_3 = Application.create!(applicant_name: "Ben Spiegel", street_address: "6625 Main, Apt. 9", city: "Denver", state: "CO", zip_code: "80026", application_status: "In Progress")

    @shelter_1 = Shelter.create!(foster_program: 'true', name: "Shelter 1", city: "Denver", rank: "5")

    @pet_1 = @application_1.pets.create!(adoptable: "true", age: "3", breed: "Terrier", name: "Sparky", shelter_id: "#{@shelter_1.id}")

    @pet_2 = Pet.create!(adoptable: "true", age: "1", breed: "Black Lab", name: "Spot", shelter_id: "#{@shelter_1.id}")
    @pet_3 = Pet.create!(adoptable: "true", age: "6", breed: "Yellow Lab", name: "Bow Wow", shelter_id: "#{@shelter_1.id}")
    @pet_4 = Pet.create!(adoptable: "true", age: "11", breed: "Bulldog", name: "Spot", shelter_id: "#{@shelter_1.id}")
    @pet_5 = Pet.create!(adoptable: "true", age: "11", breed: "Bulldog", name: "Sally", shelter_id: "#{@shelter_1.id}")
  end

  it "shows application and it's attributes" do
    visit "/applications/#{@application_1.id}"

    expect(page).to have_content(@application_1.applicant_name)
    expect(page).to have_content(@application_1.street_address)
    expect(page).to have_content(@application_1.city)
    expect(page).to have_content(@application_1.state)
    expect(page).to have_content(@application_1.zip_code)
    expect(page).to have_content("Applicant Description: Incomplete")
    expect(page).to have_content(@application_1.application_status)
    expect(page).to have_content(@pet_1.name)
    expect(page).to have_link("#{@pet_1.name}", href: "/pets/#{@pet_1.id}")

    visit "/applications/#{@application_2.id}"

    expect(page).to have_content(@application_2.applicant_name)
    expect(page).to have_content(@application_2.street_address)
    expect(page).to have_content(@application_2.city)
    expect(page).to have_content(@application_2.state)
    expect(page).to have_content(@application_2.zip_code)
    expect(page).to have_content("Applicant Description: Incomplete")
    expect(page).to have_content(@application_2.application_status)
    expect(page).to have_no_content(@pet_1.name)
  end

  describe 'add pet to application' do
    before :each do
      visit "/applications/#{@application_1.id}"
    end

    it 'has heading for add pet' do
      expect(page).to have_content("Add a Pet to this Application:")
    end

    it 'has a form to search pet names' do
      expect(page).to have_field("Pet Name")
      expect(page).to have_content("Pet Name")
    end

    it 'has a search button' do
      expect(page).to have_button("Search")
    end

    it ' returns pets when searched by name' do
      expect(page).to have_no_content("Spot")

      fill_in 'pet_name', with: "#{@pet_2.name}"
      click_button "Search"

      page.has_current_path?("/applications/#{@application_1.id}?search=pet_name")

      expect(page).to have_content("Spot")
    end

    it 'has a link next to pet name to adopt them which adds them to pets to adopt list' do
      fill_in 'pet_name', with: "#{@pet_2.name}"
      click_button "Search"

      expect(page).to have_content(@pet_2.name)
      expect(page).to have_content(@pet_4.name)
      expect(@pet_2.name).to eq(@pet_4.name)

      within("#search#{@pet_2.id}") do
        expect(page).to have_button('Adopt this Pet')
        click_button "Adopt this Pet"
      end

      expect("Sparky").to appear_before("#{@pet_2.name}", only_text: true)
      expect(page).to have_link("#{@pet_2.name}", href: "/pets/#{@pet_2.id}")
    end

    it 'does not display when application status is pending' do
      visit "/applications/#{@application_2.id}"
      expect(page).to have_no_content("Add a Pet to this Application:")
      expect(page).to_not have_field("Pet Name")
    end

    it 'searches names based on near matches' do
      fill_in 'pet_name', with: "s"
      click_button "Search"

      expect(page).to have_content(@pet_2.name)
      expect(page).to have_content(@pet_1.name)
      expect(page).to have_content(@pet_5.name)

      fill_in 'pet_name', with: "sp"
      click_button "Search"

      expect(page).to have_content(@pet_2.name)
      expect(page).to have_content(@pet_1.name)
    end

    it 'searches names case insensitive' do
      pet_1 = Pet.create!(adoptable: "true", age: "3", breed: "Terrier", name: "SPARKY", shelter_id: "#{@shelter_1.id}")
      pet_2 = Pet.create!(adoptable: "true", age: "1", breed: "Black Lab", name: "SpArKy", shelter_id: "#{@shelter_1.id}")
      pet_3 = Pet.create!(adoptable: "true", age: "6", breed: "Yellow Lab", name: "sparky", shelter_id: "#{@shelter_1.id}")
      pet_4 = Pet.create!(adoptable: "true", age: "11", breed: "Bulldog", name: "SPArky", shelter_id: "#{@shelter_1.id}")

      fill_in 'pet_name', with: "sp"
      click_button "Search"

      expect(page).to have_content(pet_1.name)
      expect(page).to have_content(pet_2.name)
      expect(page).to have_content(pet_3.name)
      expect(page).to have_content(pet_4.name)
    end

    it 'returns names regardless of case in search' do
      pet_1 = Pet.create!(adoptable: "true", age: "3", breed: "Terrier", name: "SPARKY", shelter_id: "#{@shelter_1.id}")
      pet_2 = Pet.create!(adoptable: "true", age: "1", breed: "Black Lab", name: "SpArKy", shelter_id: "#{@shelter_1.id}")
      pet_3 = Pet.create!(adoptable: "true", age: "6", breed: "Yellow Lab", name: "sparky", shelter_id: "#{@shelter_1.id}")
      pet_4 = Pet.create!(adoptable: "true", age: "11", breed: "Bulldog", name: "SPArky", shelter_id: "#{@shelter_1.id}")

      fill_in 'pet_name', with: "SPAR"
      click_button "Search"

      expect(page).to have_content(pet_1.name)
      expect(page).to have_content(pet_2.name)
      expect(page).to have_content(pet_3.name)
      expect(page).to have_content(pet_4.name)
    end
  end

  describe 'submission' do
    it 'has a button to submit when a pet has been added for adoption' do
      visit "/applications/#{@application_3.id}"

      expect(page).to have_no_content("Please describe why you would be a good home for these pets.")
      expect(page).to_not have_field(:description)
      expect(page).to_not have_button('Submit Application')

      expect(page).to have_button("Search")
      expect(page).to have_field(:pet_name)

      fill_in 'pet_name', with: "#{@pet_2.name}"
      click_button "Search"

      expect("Add a Pet to this Application:").to appear_before(@pet_2.name, only_text: true)

      within("#search#{@pet_2.id}") do
        expect(page).to have_button('Adopt this Pet')
        click_button "Adopt this Pet"
      end

      expect(@pet_2.name).to appear_before("Add a Pet to this Application:", only_text: true)

      expect(page).to have_link("#{@pet_2.name}", href: "/pets/#{@pet_2.id}")
      expect(page).to have_content("Please describe why you would be a good home for these pets.")
      expect(page).to have_field(:description)
      expect(page).to have_button('Submit Application')
      fill_in :description, with: "I'm a good trainer."

      click_button 'Submit Application'

      expect(current_path).to eq("/applications/#{@application_3.id}")
      expect(page).to have_content("Application Status: Pending")
      expect("Pet Name(s):").to appear_before(@pet_2.name, only_text: true)

      expect(page).to have_no_content("Please describe why you would be a good home for these pets.")
      expect(page).to_not have_field(:description)
      expect(page).to_not have_button('Submit Application')
      expect(page).to_not have_button("Search")
      expect(page).to_not have_field(:pet_name)
    end
  end
end
