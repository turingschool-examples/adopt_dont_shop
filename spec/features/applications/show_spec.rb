require 'rails_helper'

RSpec.describe 'the application show' do
  it 'shows the application and all its attributes' do
    application = Application.create!(
                                      name: "Nate Brown",
                            street_address: "2000 35th Avenue",
                                      city: "Denver",
                                     state: "CO",
                                       zip: "90210",
                               description: "I have a big backyard",
                                    status: "In Progress"
                                      )
    shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    application.pets.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)
    application.pets.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
    visit "/applications/#{application.id}"
    
    expect(page).to have_content(application.name)
    expect(page).to have_content(application.full_address)
    expect(page).to have_content(application.description)
    expect(page).to have_content(application.status)
    page.has_link?("Lobster")
    page.has_link?("Lucille Bald")
  end
end
