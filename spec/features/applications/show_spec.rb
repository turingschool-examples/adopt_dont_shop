require 'rails_helper'

RSpec.describe 'The pet application show page' do
  before(:each) do
    @fancy = Shelter.create!(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    @coony = @fancy.pets.create!(name: 'Coony', breed: 'Maine Coon', age: 10, adoptable: true)
    @bloom = @fancy.pets.create!(name: 'Irishman', breed: 'irish wolfhound', age: 2, adoptable: true)
    @sage = @fancy.pets.create(name: 'Sage', breed: 'irish wolfhound', age: 8, adoptable: true)
    @pirate = @fancy.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @clawdia = @fancy.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
      
    @app1 = Application.create!(name: "Tucker", street_address: "1122 Blank St.", city: 'New York City', state: "NY", zip_code: "12121", description: "We have one happy dog and would love another!", status: "In Progress") 
    @app2 = Application.create!(name: "Sara", street_address: "2211 Other St.", city: 'Iowa City', state: "IA", zip_code: "33434", description: "Give pet please", status: "Pending") 
    
    @petapp1 = PetApplication.create!(pet: @coony, application: @app1)
    @petapp1 = PetApplication.create!(pet: @bloom, application: @app1)
    @petapp2 = PetApplication.create!(pet: @bloom, application: @app2)
  end

  it 'has the name, address, description, names of pets, and status displayed' do
    visit "/applications/#{@app1.id}"

    # within block
    expect(page).to have_content(@app1.name)
    expect(page).to have_content(@app1.street_address)
    expect(page).to have_content(@app1.city)
    expect(page).to have_content(@app1.zip_code)
    expect(page).to have_content(@app1.description)
    expect(page).to have_content(@app1.status)
    expect(page).to have_content(@bloom.name)
    expect(page).to have_content(@coony.name)
    expect(page).to_not have_content(@app2.name)
  end

  it 'has links to each pet via the name of the pet on the applicaiton' do
    visit "/applications/#{@app1.id}"

    expect(page).to have_link "#{@coony.name}", href: "/pets/#{@coony.id}"
    expect(page).to have_link "#{@bloom.name}", href: "/pets/#{@bloom.id}"
  end
  
  describe "has an Add a Pet section" do
    before(:each) do
      visit "/applications/#{@app1.id}"
    end

    it 'has an Add a Pet section with a field to search for Pets' do
      within("#add_pet_to_app") do 
        expect(page).to have_content "Add a Pet to this Application"
        expect(page).to have_button "Search"
      end
    end

    it 'can display Pets based on a search query' do
      
      fill_in(:query, with: "Mr. Pirate")
      click_button "Search"

      expect(current_path).to eq "/applications/#{@app1.id}"
      
      #User story is unclear what information should be displayed upon searching.
      within("#add_pet_to_app") do 
        expect(page).to have_content @pirate.name
        expect(page).to_not have_content @sage.name
      end
    end

    it 'can display Pets whose names are a close match' do

      fill_in(:query, with: "age")
      click_button "Search"
      
      expect(current_path).to eq "/applications/#{@app1.id}"
      
      within("#add_pet_to_app") do 
        expect(page).to have_content @sage.name
        expect(page).to_not have_content @pirate.name
      end
    end

    it 'can display Pets whose names match a case insensitive search' do

      fill_in(:query, with: "aGE")
      click_button "Search"
      
      expect(current_path).to eq "/applications/#{@app1.id}"
      
      within("#add_pet_to_app") do 
        expect(page).to have_content @sage.name
        expect(page).to_not have_content @pirate.name
      end
    end
  end
end