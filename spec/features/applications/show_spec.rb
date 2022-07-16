require 'rails_helper'

RSpec.describe 'application show page' do
  it 'show all information about an applicant when you visit the page' do
    blake_application = Application.create!(
      name: 'Blake Saylor',
      street_address: '638 East Franklin Place',
      city: 'Edmond',
      state: 'CO',
      zipcode: 80235,
      description: 'I just want a cat and I will be nice to it.',
      status: 'Pending')

    aurora_shelter = Shelter.create(name: 'Aurora shelter',
                                    city: 'Aurora, CO',
                                    foster_program: false,
                                    rank: 9)

    lucille_bald = Pet.create!(name: 'Lucille Bald',
                                breed: 'sphynx',
                                age: 8,
                                adoptable: true,
                                shelter_id: aurora_shelter.id)

    blue = Pet.create!(name: "blue",
                      breed: "Golden",
                      age: 3,
                      adoptable: true,
                      shelter_id: aurora_shelter.id)

    ApplicationPet.create!(pet: blue,
                          application: blake_application)

    ApplicationPet.create!(pet: lucille_bald,
                          application: blake_application)

    visit "/applications/#{blake_application.id}"

    expect(page).to have_content(blake_application.name)
    expect(page).to have_content(blake_application.street_address)
    expect(page).to have_content(blake_application.city)
    expect(page).to have_content(blake_application.state)
    expect(page).to have_content(blake_application.zipcode)
    expect(page).to have_content(blake_application.description)
    expect(page).to have_content(blake_application.status)
    expect(page).to have_content(blue.name)
    expect(page).to have_content(lucille_bald.name)
  end

  it 'has links to all pets on an application' do
    blake_application = Application.create!(
      name: 'Blake Saylor',
      street_address: '638 East Franklin Place',
      city: 'Edmond',
      state: 'CO',
      zipcode: 80235,
      description: 'I just want a cat and I will be nice to it.',
      status: 'Pending')

    aurora_shelter = Shelter.create(name: 'Aurora shelter',
                                    city: 'Aurora, CO',
                                    foster_program: false,
                                    rank: 9)

    lucille = Pet.create!(name: 'Lucille Bald',
                                breed: 'sphynx',
                                age: 8,
                                adoptable: true,
                                shelter_id: aurora_shelter.id)

    blue = Pet.create!(name: "blue",
                      breed: "Golden",
                      age: 3,
                      adoptable: true,
                      shelter_id: aurora_shelter.id)

    yellow = Pet.create!(name: "yellow",
                        breed: "Golden",
                        age: 3,
                        adoptable: true,
                        shelter_id: aurora_shelter.id)

    ApplicationPet.create!(pet: blue,
                          application: blake_application)

    ApplicationPet.create!(pet: lucille,
                          application: blake_application)

    visit "/applications/#{blake_application.id}"

    expect(page).to have_link("#{lucille.name}", href: "/pets/#{lucille.id}")
    expect(page).to have_link("#{blue.name}", href: "/pets/#{blue.id}")
    expect(page).to_not have_link("#{yellow.name}", href: "/pets/#{yellow.id}")

    click_link("#{lucille.name}")

    expect(current_path).to eq("/pets/#{lucille.id}")
  end
end
