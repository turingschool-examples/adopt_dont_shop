require 'rails_helper'

RSpec.describe 'application show page' do
  it "shows the application and all it's attributes" do
    shelter = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    scooby = Pet.create(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
    john_doe_app = Application.create!(name: 'John Doe', street_address: '656 Main St.', city: 'Birmingham', state: 'AL', zip_code: 85267, description: "I've been a dog trainer for 40 years and I spend most of my days at home.", status: 'In Progress')
    john_doe_app.pets << scooby

    visit "/applications/#{john_doe_app.id}"
    # save_and_open_page
    expect(page).to have_content(john_doe_app.name)
    expect(page).to have_content(john_doe_app.street_address)
    expect(page).to have_content(john_doe_app.description)
    expect(page).to have_content(john_doe_app.status)
  end
end