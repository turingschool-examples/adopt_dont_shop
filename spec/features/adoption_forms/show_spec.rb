require 'rails_helper'

describe 'Pet adoption application show page', type: :feature do
  it 'displays all details of the pet application' do
    form = create(:adoption_form)
    visit "/adoption_forms/#{form.id}"
    save_and_open_page

    expect(page).to have_content("Application Info")
    expect(page).to have_content("First Name: #{form.first_name}")
    expect(page).to have_content("Last name: #{form.last_name}")
    expect(page).to have_content("Street address: #{form.street_address}")
    expect(page).to have_content("City: #{form.city}")
    expect(page).to have_content("State: #{form.state}")
    expect(page).to have_content("Zip code: #{form.zip_code}")
    expect(page).to have_content("Description of home: #{form.description}")
  end
end
