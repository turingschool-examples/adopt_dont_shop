require 'rails_helper'

RSpec.describe 'application' do
  it 'displays a link to all pets' do
    visit '/'
    expect(page).to have_content("Adopt, don't shop!")
    expect(page).to have_link("Pets")
    click_link("Pets")
    expect(page).to have_current_path('/pets')
  end

  it 'displays a link to all shelters' do
    visit '/'

    expect(page).to have_link("Shelters")
    click_link("Shelters")
    expect(page).to have_current_path('/shelters')
    expect(page).to have_link("Shelters")
    expect(page).to have_link("Pets")
    expect(page).to have_link("Veterinarians")
    expect(page).to have_link("Veterinary Offices")
  end

  it 'displays a link to all veterinary offices' do
    visit '/'

    expect(page).to have_link("Veterinary Offices")
    click_link("Veterinary Offices")
    expect(page).to have_current_path('/veterinary_offices')
    expect(page).to have_link("Shelters")
    expect(page).to have_link("Pets")
    expect(page).to have_link("Veterinarians")
    expect(page).to have_link("Veterinary Offices")
  end

  it 'displays a link to all veterinarians' do
    visit '/'

    expect(page).to have_link("Veterinarians")
    click_link("Veterinarians")
    expect(page).to have_current_path('/veterinarians')
    expect(page).to have_link("Shelters")
    expect(page).to have_link("Pets")
    expect(page).to have_link("Veterinarians")
    expect(page).to have_link("Veterinary Offices")
  end

  it 'has a show page' do
    dfl = Shelter.create!(foster_program: true, name: "Dumb friends League", city: "Denver", rank: 53)
    spike = dfl.pets.create!(adoptable: true, age: 1, breed: "Golden Retriever", name: "Spike")
    meow = dfl.pets.create!(adoptable: true, age: 2, breed: "tiger", name: "Meow")
    jim = Application.create!(name: "Jim", street_address: "123 Test Street", city: "Makebelivevill", state: "Florida", zip_code: 80233, description: "Need Companion")
    PetApplication.create!(pet: spike, application: jim)

    visit "/applications/#{jim.id}"

    expect(page).to have_content(jim.name)
    expect(page).to have_content(jim.street_address)
    expect(page).to have_content(jim.city)
    expect(page).to have_content(jim.state)
    expect(page).to have_content(jim.zip_code)
    expect(page).to have_content(jim.description)
    expect(page).to have_content(jim.status)

    expect(page).to have_content(spike.name)
    
  end

  it 'pet name is a link to pet show page' do
    dfl = Shelter.create!(foster_program: true, name: "Dumb friends League", city: "Denver", rank: 53)
    spike = dfl.pets.create!(adoptable: true, age: 1, breed: "Golden Retriever", name: "Spike")
    meow = dfl.pets.create!(adoptable: true, age: 2, breed: "tiger", name: "Meow")
    jim = Application.create!(name: "Jim", street_address: "123 Test Street", city: "Makebelivevill", state: "Florida", zip_code: 80233, description: "Need Companion")
    PetApplication.create!(pet: spike, application: jim)

    visit "/applications/#{jim.id}"

    expect(page).to have_link("#{spike.name}")

    click_link("#{spike.name}")

    expect(current_path).to eq("/pets/#{spike.id}")

  end

end
