require 'rails_helper'

RSpec.describe 'the application show page' do
  before(:each) do
    @app1 = Application.create!(name: "Max", 
                                street_address: "Made up St", city: "Denver", 
                                state: "CO", 
                                zip_code: "80000", 
                                description: "Love mix breeds. Lots of energy to play with a dog", 
                                status: "In Progress")
    @app2 = Application.create!(name: "Alastair", 
                                street_address: "Fictional St", 
                                city: "Golden", 
                                state: "CO", 
                                zip_code: "80001", 
                                description: "Love big dogs. Great mountain walks on doorstep", 
                                status: "Accepted")
    @app3 = Application.create!(name: "Chloe", 
                                street_address: "Fake Street", 
                                city: "Denver", 
                                state: "CO", 
                                zip_code: "80002", 
                                status: "In Progress")
    @shelter = Shelter.create!(name: 'Aurora shelter', 
                                city: 'Aurora, CO', 
                                foster_program: false, 
                                rank: 9)
    @pet1 = @app1.pets.create!(name: 'Noodle', 
                                age: 2, 
                                breed: 'Border Collie', 
                                adoptable: true, 
                                shelter_id: @shelter.id)
    @pet2 = @app1.pets.create!(name: 'Hercules', 
                                age: 2, 
                                breed: 'American Akita', 
                                adoptable: true, 
                                shelter_id: @shelter.id)
    @pet3 = Pet.create!(name: 'Bumblebee', 
                                age: 1, 
                                breed: 'Welsh Corgi', 
                                adoptable: true,
                                shelter_id: @shelter.id)
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
  end
  
  it 'does not render a search bar for pets if application is not in progress' do
    visit "/applications/#{@app2.id}"
    
    expect(page).not_to have_content('Add a Pet to this Application')
    expect(page).not_to have_selector(:button, 'Search Pets')
  end
  
  it 'search bar returns results from partial texts, case insensitive' do
    visit "/applications/#{@app1.id}"
    
    fill_in 'Add a Pet to this Application', with: "bum"
    click_button 'Search Pets'
    
    expect(page).to have_content("#{@pet3.name}")
  end
  
  it 'search function can be filled and will return results on the application page' do
    visit "/applications/#{@app1.id}"
    
    fill_in 'Add a Pet to this Application', with: "#{@pet3.name}"
    click_button 'Search Pets'

    expect(page).to have_content(@pet3.name)
    click_on 'Bumblebee'
    expect(current_path).to eq ("/pets/#{@pet3.id}")
  end

  it 'has a link to Adopt this Pet after searching' do
    visit "/applications/#{@app1.id}"
    
    fill_in 'Add a Pet to this Application', with: "#{@pet2.name}"
    click_button 'Search Pets'
    expect(page).to have_content('Hercules')
    expect(page).to have_button('Adopt this pet')
    expect("Hercules").to appear_before('Adopt this pet')
  end

  it 'lets you add a pet to an application' do
    visit "/applications/#{@app1.id}"

    fill_in 'Add a Pet to this Application', with: "#{@pet3.name}"
    click_button 'Search Pets'

    click_button 'Adopt this pet'
    save_and_open_page
    expect(page).to have_content('Bumblebee')
    expect(@app1.pets).to eq([@pet1, @pet2, @pet3])
  end
  
  it 'can submit an application after adding pets' do
    visit "/applications/#{@app1.id}"
    
    expect(page).to have_link('Noodle')
    expect("Interested in adopting:").to appear_before('Noodle')
    expect(page).to have_content('Why I would make a good owner:')
    
    
    fill_in 'Why I would make a good owner:', with: "Love large dogs. Lots of energy to play with a dog."
    
    click_button('Submit Application')
    
    expect(page).to have_content("Love large dogs. Lots of energy to play with a dog.")
  end
  
  it 'will not have a submit button if the application has no pets' do
    visit "/applications/#{@app3.id}"

    expect(page).to_not have_button('Submit Application')
  end
end