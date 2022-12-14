require 'rails_helper'

RSpec.describe 'the application show' do

  before :each do
    @application = create(:application)
    # @application_2 = create(:application)
    @shelter_1     = create(:shelter)
    @pet_1         = create(:pet, shelter: @shelter_1)
    @pet_2         = create(:pet, shelter: @shelter_1)
    @pet_3         = create(:pet, shelter: @shelter_1)
  end

  describe 'User Story #1' do
    it "shows the application and all it's attributes" do

      visit "/applications/#{@application.id}"

      expect(page).to have_content(@application.name)
      expect(page).to have_content(@application.street_address)
      expect(page).to have_content(@application.city)
      expect(page).to have_content(@application.state)
      expect(page).to have_content(@application.zip_code)
      expect(page).to have_content(@application.description)
      expect(page).to have_content(@pet_1.name)
      expect(page).to have_content(@application.status)
    end
  end

  describe 'User Story #4' do
    it 'can show a form to search for pets by name' do

      @application.status = "in progress" unless @application.status == "in progress"
      @application.save

      visit "/applications/#{@application.id}"
      fill_in('search', with: @pet_1.name)
      click_button 'search'

      expect(current_path).to eq("/applications/#{@application.id}")
      expect(page).to have_content(@pet_1.name)
    end
  end

  describe 'User Story #4 (cont.)' do
    it 'links to pet objects via search and list' do

      @application.status = "in progress" unless @application.status == "in progress"
      @application.save

      visit "/applications/#{@application.id}"
      within(:xpath, '//div[@class="avail-pets-cta"]') do
        click_link @pet_1.name
      end

      expect(current_path).to eq("/applications/pets/#{@pet_1.id}")

      visit "/applications/#{@application.id}"
      fill_in('search', with: @pet_1.name)
      click_button 'search'

      expect(current_path).to eq("/applications/#{@application.id}")
      
      within(:xpath, '//div[@class="search-pets-cta"]') do
        click_link @pet_1.name
      end

      expect(current_path).to eq("/applications/pets/#{@pet_1.id}")
    end
  end

  describe 'User Story #5' do
    it 'displays an "Adopt Me" button next to search pets results' do

      @application.status = "in progress" unless @application.status == "in progress"
      @application.save

      visit "/applications/#{@application.id}"
      fill_in('search', with: @pet_1.name)
      click_button 'search'

      expect(page).to have_button("Adopt Me")

      click_button "Adopt Me"

      within(:xpath, '//div[@class="select-pets-cta"]') do
        click_link @pet_1.name
      end

      expect(current_path).to eq("/applications/pets/#{@pet_1.id}")
    end
  end

  describe 'User Story 6' do
    it 'displays a submit button & statement field if pets are added to application' do
      
      expect(page).to_not have_button("Submit")

      @application.status = "in progress" unless @application.status == "in progress"
      @application.save

      visit "/applications/#{@application.id}"
      fill_in('search', with: @pet_1.name)
      click_button 'search'

      expect(page).to have_button("Adopt Me")

      click_button "Adopt Me"

      expect(page).to have_button("submit")
      expect(page).to have_field("statement")
    end

    it 'changes status of application and removes search if submit pressed' do

      expect(page).to_not have_button("Submit")

      @application.status = "in progress" unless @application.status == "in progress"
      @application.save

      visit "/applications/#{@application.id}"
      fill_in('search', with: @pet_1.name)
      click_button 'search'
      click_button "Adopt Me"

      fill_in('statement', with: "I am a human")

      click_button "submit"

      expect(page).to have_content("Status: pending")
      expect(page).to_not have_button("search")
      expect(page).to_not have_button("submit")
      expect(current_path).to eq("/applications/#{@application.id}")
    end
  end
end
