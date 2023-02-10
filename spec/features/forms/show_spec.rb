require 'rails_helper'

RSpec.describe 'Form page', type: :feature do
  describe 'as a visitor' do
    before :each do
      @shelter_1 = Shelter.create!(foster_program: false, name: "The Farm", city: "Denver", rank: 2)
      @pet_1 = Pet.create!(adoptable: true, age: 1, breed: "Great Dane", shelter_id: @shelter_1.id, name: 'Scooby')
      @app_1 = Form.create!(name: "John Smith", street_address: "123 Main St.", city: "Denver", state: "CO", zip_code: 80202, description: "I want a pet.", status: 0)
    end
    describe 'When I visit a forms show page' do
      it "Then I can see the following:
      - Name of the Applicant
      - Full Address of the Applicant including street address, city, state, and zip code
      - Description of why the applicant says they'd be a good home for this pet(s)
      - names of all pets that this application is for (all names of pets should be links to their show page)
      - The Application's status, either In Progress, Pending, Accepted, or Rejected" do
  
        visit "/forms/#{@app_1.id}"
        
        expect(current_path).to eq("/forms/#{@app_1.id}")
        expect(page).to have_content("Name of Applicant")
        expect(page).to have_content("Street Address")
        expect(page).to have_content("City")
        expect(page).to have_content("State")
        expect(page).to have_content("Zip Code")
        expect(page).to have_content("Description")
        expect(page).to have_content("Names of Pets")
        expect(page).to have_content("Application Status")
      end
    end

    # 2. Starting an Application

    describe 'When I fill in this form with my info And I click submit' do
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
  end
end