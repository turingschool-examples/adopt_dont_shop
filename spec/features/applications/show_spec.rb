require "rails_helper"


RSpec.describe("Application Show Page") do
  before(:each) do
    @smithers_application = Application.create!(    name: "Smithers",     street_address: "99 Higgins Estate",     city: "Springfield",     state: "IL",     zip_code: 90597,     description: "I have a lot of land and no friends",     status: "In Progress")
    @homer_application = Application.create!(    name: "Homer",     street_address: "24 East Ridge",     city: "Springfield",     state: "IL",     zip_code: 90597,     description: "since the drinking hole closed i have a lot of time on my hands and no friends",     status: "In Progress")
    @shelter = Shelter.create(    name: "Mystery Building",     city: "Irvine CA",     foster_program: false,     rank: 9)
    @scooby = Pet.create(    name: "Scooby",     age: 2,     breed: "Great Dane",     adoptable: true,     shelter_id: @shelter.id)
    @pablo = Pet.create(    name: "Pablo",     age: 1,     breed: "Chihuahua",     adoptable: true,     shelter_id: @shelter.id)
    @pet_app_1 = PetApplication.create!(    pet: @pablo,     application: @smithers_application)
  end

  it("shows an application's attributes") do
    visit("/applications/#{@smithers_application.id}")
    expect(page).to(have_content("Application Show Page"))
    expect(page).to(have_content(@smithers_application.name))
    expect(page).to(have_content(@smithers_application.street_address))
    expect(page).to(have_content(@smithers_application.city))
    expect(page).to(have_content(@smithers_application.state))
    expect(page).to(have_content(@smithers_application.zip_code))
    expect(page).to(have_content(@smithers_application.description))
    expect(page).to(have_content(@smithers_application.status))
    expect(page).to(have_content(@pablo.name))
    expect(page).not_to(have_content(@homer_application.name))
    expect(page).not_to(have_content(@scooby.name))
    expect(page).not_to(have_content(@scooby.age))
    expect(page).not_to(have_content(@shelter.foster_program))
  end

  it("has a link to the pet's show page") do
    visit("/applications/#{@smithers_application.id}")
    expect(page).to(have_link("#{@pablo.name}"))
    expect(page).not_to(have_link("#{@scooby.name}"))
    expect(page).not_to(have_link("#{@homer_application.id}"))
    click_link("#{@pablo.name}")
    expect(current_path).to eq("/pets/#{@pablo.id}")
    expect(current_path).not_to(eq("/pets/#{@scooby.id}"))
  end

  describe("if the application has not been submitted") do
    describe("I see a section on the page to Add a Pet to this Application") do
      describe("In that section I see an input where I can search for Pets by name") do
        describe("When I fill in this field with a Pet's name And I click submit,") do
          describe("Then I am taken back to the application show page") do
            it ("#4.And under the search bar I see any Pet whose name matches my search") do
              visit("/applications/#{@smithers_application.id}")
              fill_in(:search,               with: "Scooby")
              click_button("Search")
              expect(current_path).to eq("/applications/#{@smithers_application.id}")
              # save_and_open_page
            end
          end
        end
      end
    end
  end
end
