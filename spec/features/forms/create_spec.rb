require 'rails_helper'

RSpec.describe "create" do
  before :each do
    @shelter_1 = Shelter.create!(foster_program: false, name: "The Farm", city: "Denver", rank: 2)
    @pet_1 = Pet.create!(adoptable: true, age: 1, breed: "Great Dane", shelter_id: @shelter_1.id, name: 'Scooby')
    @app_1 = Form.create!(name: "John Smith", street_address: "123 Main St.", city: "Denver", state: "CO", zip_code: 80202, description: "I want a pet.", status: 0)
  end
  describe 'When I fill in this form with my info And I click submit' do
       # 2. Starting an Application
    it 'Then I am taken to the new applications show page' do
      visit '/forms/new'
  
      fill_in "Name:", with: "#{@app_1.name}"
      fill_in "Street Address:", with: "#{@app_1.street_address}"
      fill_in "City:", with: "#{@app_1.city}"
      fill_in "State:", with: "#{@app_1.state}"
      fill_in "Zip Code:", with: "#{@app_1.zip_code}"
      fill_in "Description:", with: "#{@app_1.description}"
      fill_in "Application Status:", with: "#{@app_1.status}"
  
      click_button "Submit"
  
      expect(current_path).to eq("/forms/#{Form.last.id}")
      expect(page).to have_content(Form.last.name)
      expect(page).to have_content(Form.last.street_address)
      expect(page).to have_content(Form.last.city)
      expect(page).to have_content(Form.last.state)
      expect(page).to have_content(Form.last.zip_code)
      expect(page).to have_content(Form.last.description)
      expect(page).to have_content(Form.last.status)
    end
  end
  # 3. Starting an Application, Form not Completed
 
  describe "When I visit the new application page, And I fail to fill in any of the form fields " do
    it 'Then I am taken back to the new applications page and I see a message that I must fill in those fields.' do
      visit '/forms/new'
      fill_in "Name:", with: "#{@app_1.name}"
      fill_in "Street Address:", with: "#{@app_1.street_address}"
      fill_in "City:", with: "#{@app_1.city}"
      fill_in "State:", with: "#{@app_1.state}"
      click_button "Submit"
save_and_open_page
      expect(current_path).to eq("/forms/#{Form.last.id}")
      expect(page).to have_content(Form.last.name)
      expect(page).to have_content(Form.last.street_address)
      expect(page).to have_content(Form.last.city)
      expect(page).to have_content(Form.last.state)
      expect(page).to_not have_content(Form.last.zip_code)
      expect(page).to have_content("Please fill out this field.")
    end
  end
end