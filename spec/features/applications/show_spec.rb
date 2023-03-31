require 'rails_helper'

RSpec.describe 'Application Show', type: :feature do
  let!(:applicant1) { Application.create!(name: "Jamison Ordway", street_address: '123 Cat St', city: 'Denver', state: 'CO', zip_code: 80238, description:"I love animals so I want to adopt them", pet_names: "/pets", status: 'In Progress') }
  let!(:applicant2) { Application.create!(name: "Brian Guthrie", address: '222 Dogs St, CO Springs, CO 80238' , description:"Dogs are my favorite", pet_names: "/pets/", status: 'In Progress') }

  it 'I see applicants name, full address, descripition, name of all pets applying for and status'  do
    visit "/applications/#{applicant1.id}"

    expect(page).to have_content('Jamison Ordway') 
    expect(page).to have_content('123 Cat St, Denver, CO 80238') 
    expect(page).to have_content("I love animals so I want to adopt them") 
    expect(page).to have_content('In Progress') 
  end
end