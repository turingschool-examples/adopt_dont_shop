require 'rails_helper'

RSpec.describe 'the application show' do
  it "shows the application and all its attributes" do
    application = Application.create!(
      name: "Jerry Blank",
      street_address: "246 DumDum Ave.",
      city: "Melbourne",
      state: "IL",
      zip_code: 53262,
      description: "I have lots of money and a big fenced-in yard and kids who are willing to walk a dog every day!",
      status: "In Progress"
    )

    visit "/applications/#{application.id}"

    expect(page).to have_content(application.name)
    expect(page).to have_content(application.street_address)
    expect(page).to have_content(application.city)
    expect(page).to have_content(application.state)
    expect(page).to have_content(application.zip_code)
    expect(page).to have_content(application.description)
    expect(page).to have_content(application.status)
  end

  it "shows the pets that the application is for and links to their show page" do
    shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    pirate = shelter.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    claw = shelter.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    joey = shelter.pets.create(name: 'Joey', breed: 'rottweiler', age: 13, adoptable: true)

    app = Application.create!(
      name: "Jerry Blank",
      street_address: "246 DumDum Ave.",
      city: "Melbourne",
      state: "IL",
      zip_code: 53262,
      description: "I have lots of money and a big fenced-in yard and kids who are willing to walk a dog every day!",
      status: "In Progress"
    )

    PetApplication.create!(pet_id: pirate.id, application_id: app.id)
    PetApplication.create!(pet_id: claw.id, application_id: app.id)
    PetApplication.create!(pet_id: joey.id, application_id: app.id)

    visit "/applications/#{app.id}"
    save_and_open_page
    expect(page).to have_link(pirate.name)
    click_link(pirate.name)
    expect(current_path).to eq("/pets/#{pirate.id}")
    save_and_open_page

    visit "/applications/#{app.id}"
    expect(page).to have_link(claw.name)
    click_link(claw.name)
    expect(current_path).to eq("/pets/#{claw.id}")

    visit "/applications/#{app.id}"
    expect(page).to have_link(joey.name)
    click_link(joey.name)
    expect(current_path).to eq("/pets/#{joey.id}")

  end
end
