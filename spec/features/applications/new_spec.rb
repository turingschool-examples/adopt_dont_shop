require "rails_helper"

RSpec.describe "create new application" do

  it "has form to fill out with applicant info" do
    visit "/applications/new"

    fill_in :name, with: "Andrew Massey"
    fill_in :street, with: "560 Wakefield Dr."
    fill_in :city, with: "Charlotte"
    fill_in :state, with: "NC"
    fill_in :zip, with: 28056
    click_button "Submit Application"

    test_application = Application.last

    expect(current_path).to eq("/applications/#{test_application.id}")
    expect(page).to have_content(test_application.name)
    expect(page).to have_content(test_application.street)
    expect(page).to have_content(test_application.city)
    expect(page).to have_content(test_application.state)
    expect(page).to have_content(test_application.zip)
  end

  it "returns an error when a field is left blank" do
    visit "/applications/new"

    fill_in :street, with: "560 Wakefield Dr."
    fill_in :city, with: "Charlotte"
    fill_in :state, with: "NC"
    fill_in :zip, with: 28056
    click_button "Submit Application"

    expect(current_path).to eq("/applications/new")
    expect(page).to have_content("Application not created: Required information missing.")
  end


end
