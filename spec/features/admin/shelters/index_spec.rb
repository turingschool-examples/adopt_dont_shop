require 'rails_helper'

RSpec.describe 'Admin Shelters Index' do
  before(:each) do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)

    @app_1 = Application.create!(first: "Joe", last: "Hill", street: "Street", city: "Any Town", state: "AnyState", zip: "12345", description: "So cute!", status: "Pending")
    @app_2 = Application.create!(first: "Susie", last: "Who", street: "1234 N A St", city: "Any Town", state: "AnyState", zip: "12345", description: "So cute!", status: "In Progress")

    @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @pet_3 = @shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)

    ApplicationPet.create!(pet: @pet_1, application: @app_1)
    ApplicationPet.create!(pet: @pet_3, application: @app_2)
  end

  it 'lists all the shelter names' do
    visit "/admin/shelters"

    expect(page).to have_content(@shelter_1.name)
    expect(page).to have_content(@shelter_2.name)
    expect(page).to have_content(@shelter_3.name)
  end

  it 'lists the shelters reverse alphabeticaly' do
    visit "/admin/shelters"

    aurora = find("#shelter-#{@shelter_1.id}")
    fancy = find("#shelter-#{@shelter_3.id}")
    rvg = find("#shelter-#{@shelter_2.id}")
    save_and_open_page
    expect(rvg).to appear_before(fancy)
    expect(fancy).to appear_before(aurora)
  end

  it 'has a section for "Shelters with Pending Applications"' do
    visit '/admin/shelters'

    expect(page).to have_content("Shelter's with Pending Applications")
  end

  it 'that lists the name of every shleter that has a pending application' do
    visit '/admin/shelters'

    within "#shelter-apps" do
      expect(page).to have_content(@shelter_1.name)
      expect(page).to_not have_content(@shelter_2.name)
      expect(page).to_not have_content(@shelter_3.name)
    end
  end
end
