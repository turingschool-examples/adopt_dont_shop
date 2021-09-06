
require 'rails_helper'

RSpec.describe 'Application Show Page' do

  before(:each) do
    @app = Application.create!(name: 'Billy',
       city: 'Denver',
      street_address: '123 lion st',
      state: 'CO',
      zip: 12345,
      status: "In Progress"
    )
    @shelter = Shelter.create!(foster_program: true,
     name: 'Bundle park',
     city: 'Denver',
     rank: 3
   )
    @dog1 = @shelter.pets.create!(adoptable: true,
       age: 2,
       breed: 'yes',
       name: 'Bob'
     )
   @dog2 = @shelter.pets.create!(adoptable: true,
      age: 2,
      breed: 'yes',
      name: 'Billy'
    )
  end

  it 'can display application info' do
    PetApplication.create!(pet: @dog1, application: @app)
    PetApplication.create!(pet: @dog2, application: @app)

    visit "/applications/#{@app.id}"

    within('#App-Info') do
      expect(page).to have_content(@app.name)
      expect(page).to have_content(@app.city)
      expect(page).to have_content(@app.street_address)
      expect(page).to have_content(@app.state)
      expect(page).to have_content(@app.zip)
      expect(page).to have_content(@dog1.name)
      expect(page).to have_content(@dog2.name)
      expect(page).to have_content(@app.description)
      expect(page).to have_content(@app.status)
      expect(page).to have_link(@dog1.name)

      click_link @dog1.name

      expect(current_path).to eq("/pets/#{@dog1.id}")
    end
  end

  it 'can search for pets' do
    visit "/applications/#{@app.id}"

    expect(page).to have_content('Add a Pet to this Application')
    expect(page).to_not have_content(@dog1.name)
    expect(page).to have_content('In Progress')

    fill_in 'search', with: @dog1.name
    click_button 'search'

    within("#Pet-Search") do
      expect(current_path).to eq("/applications/#{@app.id}")
      expect(page).to have_content(@dog1.name)
      expect(page).to_not have_content(@dog2.name)
    end

  end

  it 'can add pets to application' do
     visit "/applications/#{@app.id}"

    fill_in 'search', with: @dog2.name
    click_button 'search'

    within('#Pet-Search') do
      expect(page).to have_content(@dog2.name)
      expect(page).to have_button("Adopt #{@dog2.name}")
    end

    click_button "Adopt #{@dog2.name}"

    expect(current_path).to eq("/applications/#{@app.id}")

    within('#App-Info') do
      expect(page).to have_content(@dog2.name)
    end
  end

  it 'can submit applications' do
    app = Application.create!(name: 'Hugh', city: 'Aurora', street_address: '300 quebec st', state: 'CO', zip: 12345, status: "In Progress")

    visit "/applications/#{app.id}"

   fill_in 'search', with: @dog2.name
   click_button 'search'

   click_button "Adopt #{@dog2.name}"

   within('#Submit-Application') do
     expect(page).to have_content('Submit Application')
     expect(page).to have_content('Why would you make a good owner for these pet(s)?')
     expect(page).to have_field('description')

     fill_in 'description', with: 'I like dogs and I live on a farm'
   end

   click_button 'submit'
   expect(current_path).to eq("/applications/#{app.id}")
   expect(page).to have_content('Pending')
   expect(page).to have_content(@dog2.name)
   expect(page).to_not have_content('Add a Pet to this Application')
  end

  it 'only shows submit application when dogs have been added' do
    visit "/applications/#{@app.id}"

    expect(page).to_not have_content('Submit Application')
  end

  it 'can do partial search' do
    dog3 = @shelter.pets.create!(
      name: 'Billy Bob',
      breed: 'huntmeister',
      age: 32
    )

    visit "/applications/#{@app.id}"

    fill_in 'search', with: 'Billy'

    click_button 'search'

    within('#Pet-Search') do
      expect(page).to have_content(@dog2.name)
      expect(page).to have_content(dog3.name)
      expect(page).to have_button("Adopt #{@dog2.name}")
      expect(page).to have_button("Adopt #{dog3.name}")
    end
  end
end
