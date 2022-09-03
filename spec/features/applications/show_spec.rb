require 'rails_helper'

RSpec.describe 'the application show' do

  before :each do
    @app_1 = Application.create!(name: "Carter Ball", street_address: "123 Easy Street", city: "Atlanta", state: "GA", zip_code: 30307, description: "I want a pet")
    @app_2 = Application.create!(name: "Mary Ballantyne", street_address: "888 EZ Lane", city: "Denver", state: "CO", zip_code: 12345, description: "I would like a dog")
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
    expect(page).to have_content("In Progress")
    expect(page).to have_content(@pet_1.name)
    

    expect(page).to_not have_content(@pet_2.name)
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
      within("#addPet") do
        fill_in('Search', with: 'scoo')
        click_button("Search Pets By Name")

        expect(current_path).to eq("/applications/#{@app_1.id}")
        expect(page).to have_content(@pet_1.name)
        expect(page).to_not have_content(@pet_2.name)
      end
    end

    it 'has a button Adopt this Pet that adds a pet to an application' do
      within("#addPet") do
        fill_in('Search', with: 'scoo')
        click_button("Search Pets By Name")
        
        click_on "Adopt This Pet"

        expect(page).to have_content('Scooby')
    end
  end

  it 'shows the filled out application with pending status and the pets the user wants to adopt' do
    within("#submitForm")
    visit "/applications/#{@app_1.id}"
    fill_in 'What Would Make You A Great Owner?', with: "#{@app_1.description}"

    expect(page).to have_content('What Would Make You A Great Owner?')

    click_button 'Submit'

    expect(current_path).to eq("/applications/#{@app_1.id}")
    expect(page).to have_content("#{@app_1.description}")
    expect(page).to have_content('Status: Pending')
  end
end
