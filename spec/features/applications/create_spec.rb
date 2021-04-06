require 'rails_helper'

RSpec.describe "Creating a new Application" do
  it "when i visit the pets index page theres a link for a new application" do

    visit "/pets"
    expect(page).to have_link("Start An Application")
  end
    it "when I click on the link i go to a new applications page" do

      visit "/applications/new"
    expect(page).to have_content("New Application")
    expect(find('form')).to have_content('Name')
    expect(find('form')).to have_content('Address')
    expect(find('form')).to have_content('City')
    expect(find('form')).to have_content('State')
    expect(find('form')).to have_content('Zip code')
    end

  it 'create the applicant and redirects to the applicant show page' do
    visit "/applications/new"

    fill_in "Name", with: "Scott"
    fill_in "Address", with: "237 Nope St"
    fill_in "City", with: "No Way"
    fill_in "State", with: "USA"
    fill_in "Zip code", with: 12345
    fill_in "Description", with: "Love pets"
    fill_in "Status", with: "pending"

    click_button 'Save'

    expect(page).to have_content("Scott")
    end

  it "Shows for not Completed Error Message" do
    visit "/applications/new"

    click_button 'Save'

    expect(current_path).to eq("/applications/new")
    expect(page).to have_content("Please check your information all information must be filled in.")
  end
end
