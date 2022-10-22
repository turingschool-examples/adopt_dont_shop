require 'rails_helper'

RSpec.describe "the application show page" do 
  before :each do 
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)

    @pirate = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @clawdia = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @lucille = @shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)

    @jeff = @pirate.applications.create!(applicant: "Jeff", reason: "Lonely", status: "Pending", address: "5155 Heritage Lane, Alexandria, VA 22314")
  end

  it "displays the applicant's name" do 
    visit "/applications/#{@jeff.id}"
  
    expect(page).to have_content("Jeff")
    expect(page).to have_content("Lonely")
    expect(page).to have_content("Pending")
    expect(page).to have_content("5155 Heritage Lane, Alexandria, VA 22314")
    expect(page).to have_content("Mr. Pirate")
    expect(page).to_not have_content("Lucille Bald")

    #lucille = @jeff.pets.create!(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
    @jeff.pets << @lucille
    visit "/applications/#{@jeff.id}"
    save_and_open_page
    expect(page).to have_content("Lucille Bald")
  end
end