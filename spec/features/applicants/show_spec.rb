require 'rails_helper'

RSpec.describe "showpage" do 
  it 'shows applicants attributes and a link to their app status' do 
    @shelter5 = Shelter.create!(name: "Pet Rock Shelter", city: "Boulder", rank: 1, foster_program: true)
    @pet1 = @shelter5.pets.create!(name: "Taco", breed: "Dachshund", age: 4, adoptable: true)
    @app1 = Applicant.create!(name: "Ashley Turner", street_address: "123 Oregon Trail Way", city: "Portland", state: "OR", zip_code: "54321", description: "Pet sitting and want to have my own")
    @pet_app1 = PetApplicant.create!(pet_id: @pet1.id, applicant_id: @app1.id)

    visit "/applicants/#{@app1.id}"

    expect(page).to have_content("#{@app1.name}")
    expect(page).to have_content("#{@app1.street_address}")
    expect(page).to have_content("#{@app1.city}")
    expect(page).to have_content("#{@pet1.name}")
    expect(page).to have_link("#{@pet1.name}")
  end

  describe "#search for pets from application" do 
    it 'can add pets to an application' do 
    @shelter5 = Shelter.create!(name: "Pet Rock Shelter", city: "Boulder", rank: 1, foster_program: true)
    @pet1 = @shelter5.pets.create!(name: "Taco", breed: "Dachshund", age: 4, adoptable: true)
    @app1 = Applicant.create!(name: "Ashley Turner", street_address: "123 Oregon Trail Way", city: "Portland", state: "OR", zip_code: "54321", description: "Pet sitting and want to have my own")
    @pet_app1 = PetApplicant.create!(pet_id: @pet1.id, applicant_id: @app1.id)
      
    visit "/applicants/#{@app1.id}"
    fill_in "Search name", with: "Taco"
    
    click_button("Search")
    expect(page).to have_content(@pet1.name)
    end 
  end

  describe 'add a pet to an application' do 
    it 'adds a button next to pets from app show page' do 
      @shelter5 = Shelter.create!(name: "Pet Rock Shelter", city: "Boulder", rank: 1, foster_program: true)
      @pet1 = @shelter5.pets.create!(name: "Taco", breed: "Dachshund", age: 4, adoptable: true)
      @app1 = Applicant.create!(name: "Ashley Turner", street_address: "123 Oregon Trail Way", city: "Portland", state: "OR", zip_code: "54321", description: "Pet sitting and want to have my own")
      @pet_app1 = PetApplicant.create!(pet_id: @pet1.id, applicant_id: @app1.id)

      visit "/applicants/#{@app1.id}"
      fill_in "Search name", with: "Taco"
      click_button("Search")
      expect(page).to have_content(@pet1.name)
      click_button("Adopt This Pet!")
    end
  end
end