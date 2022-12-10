require 'rails_helper'

RSpec.describe 'the application show' do

  before :each do
    @application = create(:application)
    @shelter_1   = create(:shelter)
    @pet_1       = create(:pet, shelter: @shelter_1)
    @pet_2       = create(:pet, shelter: @shelter_1)
    @pet_3       = create(:pet, shelter: @shelter_1)
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

      visit "/applications/#{@application.id}"
      fill_in('search', with: @pet_1.name)
      click_button 'search'

      expect(current_path).to eq("/applications/#{@application.id}")
      expect(page).to have_content(@pet_1.name)
    end
  end

  describe 'User Story #4 (cont.)' do
    it 'links to pet objects via search and list' do

      visit "/applications/#{@application.id}"
      click_link @pet_1.name

      expect(current_path).to eq("/applications/pets/#{@pet_1.id}")

      visit "/applications/#{@application.id}"
      fill_in('search', with: @pet_1.name)
      click_button 'search'

      expect(current_path).to eq("/applications/#{@application.id}")

      page.all(:link, :text => @pet_1.name)[1].click

      expect(current_path).to eq("/applications/pets/#{@pet_1.id}")
    end
  end

  describe 'User Story #5' do
    it 'displays an "Adopt Me" button next to search pets results' do

      visit "/applications/#{@application.id}"
      fill_in('search', with: @pet_1.name)
      click_button 'search'

      expect(page).to have_button("Adopt Me")

      click_button "Adopt Me"

      expect(page.has_field?("Pets", with: @pet_1.name)).to be true
    end
  end
end