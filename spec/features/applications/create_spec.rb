require 'rails_helper'

RSpec.describe "the Application new page" do
  it "should add new applications" do
    application_1 = Application.create!(name: "Mary Tanaka",
                                        street_address: "123 Kapiolani Blvd.",
                                        city: "Honolulu",
                                        state: "HI",
                                        zip_code: "98684")

    visit '/pets'

    expect(page).to have_link("Start an Application")
    click_link "Start an Application"

    expect(current_path).to eq('/applications/new')
    expect(page).to have_content("Name")

    fill_in "name", with: "Mary Tanaka"
    fill_in "street_address", with: "123 Kapiolani Blvd."
    fill_in "zip_code", with: "98684"
    click_button "Save"

    expect(current_path).to eq("/applications/#{application_1.id}")

    expect(page).to have_content("Mary Tanaka")
    # expect(page).to have_content("123 Kapiolani Blvd.")
    # expect(page).to have_content("98684")
  end
end
