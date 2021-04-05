require 'rails_helper'

RSpec.describe "the Application show page" do
  it "should display applicant info" do
    applicant = Application.find_or_create_by!(name: "Fred",
                              street_address: "123 way",
                              city: "Denver",
                              state: "Colorado",
                              zip_code: 80204,
                              description: "I like dogs",
                              status: "In Progress",
                              created_at: Time.now,
                              updated_at: Time.now
                              )
    visit "/applications/#{applicant.id}"

    expect(page).to have_content(applicant.name)
    expect(page).to have_content(applicant.street_address)
    expect(page).to have_content(applicant.city)
    expect(page).to have_content(applicant.state)
    expect(page).to have_content(applicant.zip_code)
    expect(page).to have_content(applicant.description)
  end

  it "shows links that can be clicked on" do
    applicant = Application.find_or_create_by!(name: "Fred",
                              street_address: "123 way",
                              city: "Denver",
                              state: "Colorado",
                              zip_code: 80204,
                              description: "I like dogs",
                              status: "In Progress",
                              created_at: Time.now,
                              updated_at: Time.now
                              )
    visit "/applications/#{applicant.id}"

    click_link "Pets"
    click_link "Shelters"
    click_link "Veterinarians"
    click_link "Veterinary Offices"
  end
end
