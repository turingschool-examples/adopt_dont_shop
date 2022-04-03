require 'rails_helper'

RSpec.describe 'the application show' do
  it "shows the applicant and all it's attributes" do
    shelter = Shelter.create!(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    scooby = Pet.create!(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
    application = Application.create!(status: "In Progress", name: "Murmuring Savannah",
                street: '123 Main',city: 'Leadville', state: 'CO',
                zip: 11111, description: "I'm a real cool cat")

    visit "/applications/#{application.id}"

    expect(page).to have_content(application.name)
    expect(page).to have_content(application.street)
    expect(page).to have_content(application.city)
    expect(page).to have_content(application.state)
    expect(page).to have_content(application.zip)
    expect(page).to have_content(application.description)
    expect(page).to have_content(application.status)
  end

#   As a visitor
# When I visit an application's show page
# And that application has not been submitted,
# Then I see a section on the page to "Add a Pet to this Application"
# In that section I see an input where I can search for Pets by name
# When I fill in this field with a Pet's name
# And I click submit,
# Then I am taken back to the application show page
# And under the search bar I see any Pet whose name matches my search
  describe "when I visit an application's show page" do
    it "shows me a section Add a Pet to this Application" do
      application = Application.create!(status: "In Progress", name: "Murmuring Savannah",
      street: '123 Main',city: 'Leadville', state: 'CO', zip: 11111,
      description: "I'm a real cool cat")

      visit "/applications/#{application.id}"

      expect(page).to have_content("Add a Pet to this Application")
    end

    it "lets me search for pets" do
      shelter = Shelter.create!(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
      scooby = Pet.create!(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
      scrappy = Pet.create!(name: "Scrappy", age: 3, breed: 'Pug', adoptable: true, shelter_id: shelter.id)
      application = Application.create!(status: "In Progress", name: "Murmuring Savannah",
      street: '123 Main',city: 'Leadville', state: 'CO', zip: 11111,
      description: "I'm a real cool cat")

      visit "/applications/#{application.id}"

      expect(page).to_not have_content("Scooby")
      expect(page).to_not have_content("Scrappy")

      fill_in("search", with: "Scooby")
      click_on "Search"

      expect(page).to have_content("Scooby")
      expect(page).to_not have_content("Scrappy")

      visit "/applications/#{application.id}"

      fill_in("search", with: "Sc")
      click_on "Search"

      expect(page).to have_content("Scooby")
      expect(page).to have_content("Scrappy")

    end
  end
end
