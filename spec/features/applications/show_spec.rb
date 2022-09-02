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
    expect(page).to_not have_content(@app_2.name)
  end

#   As a visitor
#   When I visit an application's show page
# And I have added one or more pets to the application
# Then I see a section to submit my application
# And in that section I see an input to enter why I would make a good owner for these pet(s)
# When I fill in that input
# And I click a button to submit this application
# Then I am taken back to the application's show page
#   And I see an indicator that the application is "Pending"
#   And I see all the pets that I want to adopt
#   And I do not see a section to add more pets to this application
  it 'shows the filled out application with pending status and the pets the user wants to adopt' do
    visit "/applications/#{@app_1.id}"
    fill_in 'What Would Make You A Great Owner?', with: "#{@app_1.description}"

    expect(page).to have_content('What Would Make You A Great Owner?')

    click_button 'Submit'

    expect(current_path).to eq("/applications/#{@app_1.id}")
    expect(page).to have_content("#{@app_1.description}")
    expect(page).to have_content('Status: Pending')
  end
end
