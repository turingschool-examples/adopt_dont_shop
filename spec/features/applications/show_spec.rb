require 'rails_helper'

RSpec.describe 'visit application show page' do
  before :each do
    @shelter = Shelter.create!(name: 'Snoops Dogs', city: 'Compton', rank: 1, foster_program: true)

    @fred = @shelter.pets.create!(adoptable: true, age: 8, breed: 'Basset Hound', name: 'Fred')
    @james = @shelter.pets.create!(adoptable: true, age: 4, breed: 'King George Spaniel', name: 'James')
    @buster = @shelter.pets.create!(adoptable: true, age: 2, breed: 'Shnauzer - Wheaton mix', name: 'Buster')
    @marlowe = @shelter.pets.create!(adoptable: true, age: 9, breed: 'Pembroke Welsh Corgi', name: 'Marlowe')

    @app1 = Application.create!(name: 'Frank Sinatra', street_address: '69 Sinatra Way', city: 'Nashville', state: 'Tennessee', zip_code: '69420', description: "I've always liked dogs", status: 'In Progress')
  end

  it 'displays application details' do
    PetApplication.create!(pet: @buster, application: @app1)
    PetApplication.create!(pet: @marlowe, application: @app1)

    visit "/applications/#{@app1.id}"

    expect(page).to have_content("Application Details:")
    expect(page).to have_content("Name: #{@app1.name}")
    expect(page).to have_content("Address: #{@app1.street_address} #{@app1.city}, #{@app1.state} #{@app1.zip_code}")
    expect(page).to have_content("Application: #{@app1.description}")
    expect(page).to have_content("Application Status: #{@app1.status}")
    expect(page).to have_content("This Application is for: #{@buster.name}, #{@marlowe.name}")
  end

  it 'has links to each pet listed in application' do
    PetApplication.create!(pet: @buster, application: @app1)
    PetApplication.create!(pet: @marlowe, application: @app1)

    visit "/applications/#{@app1.id}"

    expect(find_link(@buster.name)[:href]).to eq("/pets/#{@buster.id}")
    expect(find_link(@marlowe.name)[:href]).to eq("/pets/#{@marlowe.id}")
  end

  describe 'search field' do
    it 'has a search field to find new pets to add to an application on that apps show page' do
      visit "/applications/#{@app1.id}"
  
      expect(@app1.status).not_to eq("Submitted")
      expect(page).to have_content("Add a Pet to this Application")
      expect(page).to have_field("pet_name")
  
      fill_in "pet_name", with: "Marlowe"
      click_button("Search")
  
      expect(current_path).to eq("/applications/#{@app1.id}")
      expect(page).to have_content("#{@marlowe.name}")
    end

    it 'returns partial matches for pet names' do
      visit "/applications/#{@app1.id}"
      
      fill_in "pet_name", with: "Jam"
      click_button("Search")

      expect(page).to have_content("#{@james.name}")
    end
  end

  it 'has a way to add a pet to an application' do
    james2 = @shelter.pets.create!(adoptable: true, age: 2, breed: 'Prince Albert Terrier', name: 'James')

    visit "/applications/#{@app1.id}"
    fill_in "pet_name", with: "James"
    click_button("Search")

    within "#pet-#{@james.id}" do 
      expect(page).to have_button("Adopt this Pet")
      expect(page).to have_content("James")
    end

    within "#pet-#{james2.id}" do 
      expect(page).to have_button("Adopt this Pet")
      expect(page).to have_content("James")
    end

    within "#pet-#{@james.id}" do 
      click_button("Adopt this Pet")
    end

    expect(current_path).to eq("/applications/#{@app1.id}")
    expect(page).to have_content("This Application is for: #{@james.name}")
  end

  it 'has a button to submit application once a pet has been added' do
    visit "/applications/#{@app1.id}"
    expect(page).to_not have_button("Submit Application")

    fill_in "pet_name", with: "James"
    click_button("Search")

    within "#pet-#{@james.id}" do 
      click_button("Adopt this Pet")
    end

    expect(page).to have_button("Submit Application")
    expect(page).to have_field(:description)
    fill_in :description, with: "I LOVE JAMES DANGIT"

    click_button("Submit Application")
    expect(current_path).to eq("/applications/#{@app1.id}")

    expect(page).to have_content("Application Status: Pending")
    expect(page).to_not have_content("Add a Pet to this Application")
  end
end
