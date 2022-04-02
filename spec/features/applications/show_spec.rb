require 'rails_helper'

RSpec.describe 'the application show' do
  it "shows the applicant and all it's attributes" do
    shelter = Shelter.create!(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    scooby = Pet.create!(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
    application = Application.create!(status: "In Progress", name: "Murmuring Savannah",
                street: '123 Main',city: 'Leadville', state: 'CO',
                zip: 11111, description: "I'm a real cool cat")

    # binding.pry
    visit "/applications/#{application.id}"
    expect(page).to have_content(application.name)
    expect(page).to have_content(application.street)
    expect(page).to have_content(application.city)
    expect(page).to have_content(application.state)
    expect(page).to have_content(application.zip)
    expect(page).to have_content(application.description)
    expect(page).to have_content(scooby.name)
    expect(page).to have_content(application.status)
  end
end
