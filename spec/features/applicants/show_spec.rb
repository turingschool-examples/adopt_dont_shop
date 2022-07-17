require 'rails_helper'

RSpec.describe 'the applicant show page' do
  it "shows the applicant and the completed applicants form" do
    Applicant.destroy_all
    Pet.destroy_all
    shelter = Shelter.create!(name: "Whacky Waldorf", city: "Waldorf", foster_program: false, rank: 2)
    heeny = Pet.create!(name: 'Heeny', age: 2, breed:"wyvern", adoptable: true, shelter_id: shelter.id)
    tistermickles = Pet.create!(name: 'TisterMickles', age:4, breed:'otter', adoptable: true, shelter_id: shelter.id)
    haisall = Applicant.create!(name: "Hai Sall", street_address: "123 Florida funhouse st", city: "Waldorf", state: "Maryland", zip_code: "21401", description: "The bean needs more beans", application_status: "pending")
    application = PetApplication.create!(applicant: haisall, pet: heeny)
    application2 = PetApplication.create!(applicant: haisall, pet: tistermickles)

    visit "/applicants/#{haisall.id}"

    expect(page).to have_content("Hai Sall")
    expect(page).to have_content("123 Florida funhouse st")
    expect(page).to have_content("Waldorf")
    expect(page).to have_content("Maryland")
    expect(page).to have_content("21401")
    expect(page).to have_content("The bean needs more beans")
    expect(page).to have_content("pending")

    within "#pet-#{heeny.id}" do
      click_on "#{heeny.name}"
    end
      expect(current_path).to eq("/pets/#{heeny.id}")
      expect(page).to have_link("Heeny")
      expect(page).to have_content("wyvern")

      visit "/applicants/#{haisall.id}"

    within "#pet-#{tistermickles.id}" do
      click_on "#{tistermickles.name}"
    end

    expect(current_path).to eq("/pets/#{tistermickles.id}")
    expect(page).to have_link("TisterMickles")
    expect(page).to have_content("otter")
  end

  it "can search a pets name and return the results" do
    # As a visitor
    # When I visit an application's show page
    # And that application has not been submitted,
    # Then I see a section on the page to "Add a Pet to this Application"
    # In that section I see an input where I can search for Pets by name
    # When I fill in this field with a Pet's name
    # And I click submit,
    # Then I am taken back to the application show page
    # And under the search bar I see any Pet whose name matches my search
    shelter = Shelter.create!(name: "Whacky Waldorf", city: "Waldorf", foster_program: false, rank: 2)
    heeny = Pet.create!(name: 'Heeny', age: 2, breed:"wyvern", adoptable: true, shelter_id: shelter.id)
    tistermickles = Pet.create!(name: 'TisterMickles', age:4, breed:'otter', adoptable: true, shelter_id: shelter.id)
    applicant = Applicant.create!(name: "Beannah Durke", street_address: "129 Frog lane", city: "Cuntish", state: "Colorado", zip_code: "21401", description: "I need to stomp the frogs", application_status: "In Progress")
    application = PetApplication.create!(applicant: applicant, pet: heeny)

    visit "/applicants/#{applicant.id}"
    # save_and_open_page
    expect(page).to have_content("Add a Pet to this application")
    expect(page).to have_button("Find by pet name")
    fill_in("Search", with: 'TisterMickles')
    click_on("Find by pet name")
    # save_and_open_page
    # require "pry"; binding.pry
    expect(current_path).to eq("/applicants/#{applicant.id}")
    expect(page).to have_content("TisterMickles")

  end
end
