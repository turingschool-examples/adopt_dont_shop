require 'rails_helper'

RSpec.describe 'the pet_apps show page' do
  before(:each) do
    app = App.create(name: 'Scooby', street: "123", city:"fake", state: "fake", zip: 48248)
    visit "/pet_apps/#{app.id}"
  end

  # Story 4
  # When I visit an application's show page
  # And that application has not been submitted,
  # Then I see a section on the page to "Add a Pet to this Application"
  # In that section I see an input where I can search for Pets by name
  # When I fill in this field with a Pet's name
  # And I click submit,
  # Then I am taken back to the application show page
  # And under the search bar I see any Pet whose name matches my search
  it 'when app not submitted, has a section to add a pet. Search for the pet and when fill in and submit, the pet is added' do
    expect(page).to have_button("Animals to choose from")
    expect(page).to have_button("Adopt Scooby")
  end
end