# spec/features/applications/update_spec
require 'rails_helper'

RSpec.describe 'the application update page' do
  before :each do
    @app_1 = Application.create!(name: "Suzie Kim", street_address: "123 State Street", city: "Boston", state: "Masachusetts", zip_code: 02115, description: "I'm ready to love again" )
    @app_2 = Application.create!(name: "Benjamin Blue", street_address: "545 Boston Street", city: "Houston", state: "New York", zip_code: 02115, description: "I'm also ready")
  end

  it "shows the veterinarian edit form" do
    visit "/applications/#{@app_1.id}/edit"

    expect(page).to have_content("Edit #{@app_1.name}'s Application")
    expect(page).to_not have_content("Edit #{@app_2.name}'s Application")
    expect(find('form')).to have_content('Name')
    expect(find('form')).to have_content('Street Address')
    expect(find('form')).to have_content('City')
    expect(find('form')).to have_content('State')
    expect(find('form')).to have_content('Zip code')
  end

  context "given valid data" do
    it "submits the edit form and updates the application" do
      visit "/applications/#{@app_1.id}"  
      
      expect(page).to have_content('123 State Street')
      expect(page).to have_content('Boston')
      expect(page).to have_content('02115')

      visit "/applications/#{@app_1.id}/edit"

      fill_in 'Street Address', with: '555 Other Street'
      fill_in 'City', with: 'Medford'
      fill_in 'State', with: 'Massachusetts'
      fill_in 'Zip code', with: 02155
      click_button 'Save'

      expect(page).to have_current_path("/applications/#{@app_1.id}")
      expect(page).to have_content('555 Other Street')
      expect(page).to have_content('Medford')
      expect(page).to have_content('02155')
      expect(page).to_not have_content('123 State Street')
      expect(page).to_not have_content('Boston')
      expect(page).to_not have_content('02115')
    end
  end

  context "given invalid data" do
    it 're-renders the edit form' do
      shelter = Shelter.create(name: 'Heavenly pets', city: 'Aurora, CO', foster_program: false, rank: 7)
      pet = Pet.create(adoptable: false, age: 3, breed: 'Whippet', name: 'Annabelle', shelter_id: shelter.id)

      visit "/application/#{pet.id}/edit"

      fill_in 'Name', with: ''
      click_button 'Save'

      expect(page).to have_content("Error: Name can't be blank")
      expect(page).to have_current_path("/pets/#{pet.id}/edit")
    end
  end
end
