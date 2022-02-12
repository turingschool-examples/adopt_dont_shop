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

  it "fills in the form, submits and goes to show page." do
    visit '/applications/new'

    fill_in('name', with: 'Groucho')
    fill_in('street', with: '987 real street')
    fill_in('city', with: 'Greendale')
    fill_in('state', with: 'CO')
    fill_in('zipcode', with: '09876')
    click_link 'Submit'

    expect(current_path).to eq("/applications/#{Application.last.id}")
    expect(page).to have_content('Groucho')
    expect(page).to have_content('987 real street')
    expect(page).to have_content('Greendale')
    expect(page).to have_content('CO')
    expect(page).to have_content('09876')
    expect(page).to have_content('In progress')
  end
end
