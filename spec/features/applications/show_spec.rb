require 'rails_helper'

describe 'application' do
  before(:each) do
    @shelter = Shelter.create!(foster_program: true,
                  name: "frankie's friendly felines",
                  city: "westminster",
                  rank: 10)
    @application = Application.create!(name: "Frank",
                  street: "123 blaine st",
                  city: "Sioux falls",
                  state: "SD",
                  zip: 80342,
                  description: "I'm a meat popsicle looking for a companion.",
                  status: "looking")
    @bean = Pet.create!(
                  name: "Bean",
                  adoptable: true,
                  age: 1,
                  breed: "cat",
                  shelter_id: @shelter.id)
  end
  it 'displays a link to applicant info' do
    # binding.pry
    visit "/applications/#{@application.id}"
    #save_and_open_page
    expect(page).to have_content(@application.name)
    expect(page).to have_content(@application.street)
    expect(page).to have_content(@application.city)
    expect(page).to have_content(@application.state)
    expect(page).to have_content(@application.description)
    expect(page).to have_content(@application.status)
  end
end
