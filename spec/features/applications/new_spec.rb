require 'rails_helper'

describe 'Creates a new application' do
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

  it "has a link on pet index page" do
    visit '/pets'
    click_link 'Start a new application'
    save_and_open_page
    expect(current_path).to eq('/applications/new')
  end
end
