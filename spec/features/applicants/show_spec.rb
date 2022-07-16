require 'rails_helper'

RSpec.describe 'the applicant show page' do
  # As a visitor
  # When I visit an applications show page
  # Then I can see the following:
  # - Name of the Applicant
  # - Full Address of the Applicant including street address, city, state, and zip code
  # - Description of why the applicant says they'd be a good home for this pet(s)
  # - names of all pets that this application is for (all names of pets should be links to their show page)
  # - The Application's status, either "In Progress", "Pending", "Accepted", or "Rejected"
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
end
