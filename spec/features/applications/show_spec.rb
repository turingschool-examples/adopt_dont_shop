require 'rails_helper'

RSpec.describe 'the application show' do

  before :each do
    @app_1 = Application.create!(name: "Carter Ball", street_address: "123 Easy Street", city: "Atlanta", state: "GA", zip_code: 30307, description: "I want a pet", status: "In Progress")
    @app_2 = Application.create!(name: "Mary Ballantyne", street_address: "888 EZ Lane", city: "Denver", state: "CO", zip_code: 12345, description: "I would like a dog", status: "Pending")
    @shelter_1 = Shelter.create!(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    @pet_1 = @shelter_1.pets.create!(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true)
    @pet_2 = @shelter_1.pets.create!(name: 'Gilbert', age: 4, breed: 'Mutt', adoptable: true)
    @pet_app_1 = ApplicationPet.create!(application: @app_1, pet: @pet_1)
    visit "/applications/#{@app_1.id}"
  end
  
  it "shows the application and all its attributes" do
    expect(page).to have_content(@app_1.name)
    expect(page).to have_content(@app_1.street_address)
    expect(page).to have_content(@app_1.city)
    expect(page).to have_content(@app_1.state)
    expect(page).to have_content(@app_1.zip_code)
    expect(page).to have_content(@app_1.description)
    expect(page).to have_content(@app_1.status)
    expect(page).to have_content(@pet_1.name)

    expect(page).to_not have_content(@pet_2.name)
    expect(page).to_not have_content(@app_2.status)
    expect(page).to_not have_content(@app_2.name)
  end

  describe 'the Add A Pet To This Application section'
    it 'exists and has a form with a button to search a pet' do
      within("#addPet") do
        expect(page).to have_content('Add a Pet to this Application')
        expect(find('form')).to have_content('Search')
        expect(page).to have_button("Search Pets By Name")
        expect(page).to_not have_content(@app_1.name)        
      end
    end

    it 'searches for a pet' do
      fill_in('Search', with: 'gil')
      click_button("Search Pets By Name")
      
      expect(page).to have_content(@pet_2.name)
      expect(page).to have_content(@pet_2.age)
      expect(page).to_not have_content(@pet_1.name) 
    end



end
