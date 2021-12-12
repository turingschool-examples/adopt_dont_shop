require 'rails_helper'

RSpec.describe 'applications index', type: :feature do
  it 'lists all applications' do
    application_1 = Application.create!(applicant_name: "Mike Sloan", street_address: "134 Willow Lane", city: "Boulder", state: "CO", zip_code: "80034", description: "I'd be good because I love pets", application_status: "pending")
    application_2 = Application.create!(applicant_name: "Ben Spiegel", street_address: "6625 Main, Apt. 9", city: "Denver", state: "CO", zip_code: "80026", description: "I'd be good because I already have many pets", application_status: "pending")

    visit '/applications'

    expect(page).to have_content("Application Number: #{application_1.id}")
    expect(page).to have_content("Application Number: #{application_2.id}")
  end
end
