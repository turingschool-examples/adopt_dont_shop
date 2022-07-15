require 'rails_helper'

RSpec.describe 'the applicant show page' do

  it "shows the applicant and the completed applicants form" do
    shelter = Shelter.create(name: "Whacky Waldorf", city: "Waldorf", foster_program: false, rank: 2)
    pet = Pet.create(name: 'Heeny', age: 2, breed:"wyvern", adoptable: true, shelter_id: shelter.id)
    applicant = Applicant.create(name: "Hai Sall", street_adress: "123 Florida funhouse st", city: "Waldorf", state: "Maryland", zip_code: "21401" description: "The bean needs more beans", application_status: "pending")

    visit "/applicants/#{applicant.id}"

    expect(page).to have_content("Hai Sall")
    expect(page).to have_content("123 Florida funhouse st")
    expect(page).to have_content("Waldorf")
    expect(page).to have_content("Maryland")
    expect(page).to have_content("21401")
    expect(page).to have_content("The bean needs more beans")
    expect(page).to have_content("pending")
  end
end
