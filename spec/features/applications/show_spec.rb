require 'rails_helper'

RSpec.describe 'the application show page' do
  before(:each) do
    @app1 = Application.create(name: "Max", street_address: "Made up St", city: "Denver", state: "CO", zip_code: "80000", description: "Love mix breeds. Lots of energy to play with a dog", status: "In Progress")
    @app2 = Application.create(name: "Alastair", street_address: "Fictional St", city: "Golden", state: "CO", zip_code: "80001", description: "Love big dogs. Great mountain walks on doorstep", status: "Accepted")
    @shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @pet1 = @app1.pets.create(name: 'Noodle', age: 2, breed: 'Border Collie', adoptable: true, shelter_id: @shelter.id)
    @pet2 = @app1.pets.create(name: 'Hercules', age: 2, breed: 'American Akita', adoptable: true, shelter_id: @shelter.id)
  end
  

  it 'shows the application and all its attributes' do
    visit "/applications/#{@app1.id}"
    
    expect(page).to_not have_content(@app2.name)
    expect(page).to have_content(@app1.name)
    expect(page).to have_content(@app1.street_address)
    expect(page).to have_content(@app1.city)
    expect(page).to have_content(@app1.state)
    expect(page).to have_content(@app1.zip_code)
    expect(page).to have_content(@app1.description)
    expect(page).to have_content(@app1.status)
    expect(page).to have_link(@pet1.name)
    expect(page).to have_link(@pet2.name)
    
    click_link(@pet2.name)
    expect(page).to have_current_path("/pets/#{@pet2.id}")
  end
  
  it 'has a search function for pets if application is in progress' do
    visit "/applications/#{@app1.id}"
    
    expect(page).to have_content('Add a Pet to this Application')
    expect(page).to have_selector(:button, 'Search Pets')
    # expect(subject).to render_template(partial: 'addpet')
  end
  
  it 'does not render a search bar for pets if application is not in progress' do
    visit "/applications/#{@app2.id}"
    
    expect(page).not_to have_content('Add a Pet to this Application')
    expect(page).not_to have_selector(:button, 'Search Pets')
  end
  
  it 'search function can be filled and will return results on the application page' do
    visit "/applications/#{@app1.id}"
    
    fill_in :search_text, with: "#{@pet1.name}"
    click_button 'Search Pets'
    
    expect(page).to have_content(@pet1.age)
    expect(page).to have_content(@pet1.breed)
    # expect(page).not_to have_content(@pet2.age)
    # expect(page).not_to have_content(@pet2.breed)
    # √ As a visitor
    # √ When I visit an application's show page
    # √ And that application has not been submitted,
    # √ Then I see a section on the page to "Add a Pet to this Application"
    # √ In that section I see an input where I can search for Pets by name
    # √ When I fill in this field with a Pet's name
    # √ And I click submit,
    # √ Then I am taken back to the application show page
    
    # And under the search bar I see any Pet whose name matches my search
  end
end