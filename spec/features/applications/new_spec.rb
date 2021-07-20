require 'rails_helper'

RSpec.describe "the application show page" do
  it "shows the application and all its attributes" do
    require 'rails_helper'
    # Starting an Application
    # As a visitor
    # When I visit the pet index page
    # Then I see a link to "Start an Application"
    # When I click this link
    # Then I am taken to the new application page where I see a form
    # When I fill in this form with my:
    #   - Name
    #   - Street Address
    #   - City
    #   - State
    #   - Zip Code
    # And I click submit
    # Then I am taken to the new application's show page
    # And I see my Name, address information, and description of why I would make a good home
    # And I see an indicator that this application is "In Progress"
    visit ("/pets")

    click_link("Start an Application")

    expect(current_path).to eq("/applications/new")

    fill_in('name', with: 'Shane McCutchen')
    fill_in('street', with: '1234 Pine Ave')
    fill_in('city', with: 'Arvada')
    fill_in('state', with: 'CO')
    fill_in('zip_code', with: '80218')
    fill_in('description', with: "I'm looking very Shane today")
    click_button('Submit')
    save_and_open_page
    new_application = Application.last

    expect(current_path).to eq("/applications/#{new_application.id}")
    expect(page).to have_content(new_application.name)
    expect(page).to have_content("Address: #{new_application.street} #{new_application.city}, #{new_application.state} #{new_application.zip_code}")
    expect(page).to have_content(new_application.description)
    expect(page).to have_content("Status: In Progress")
  end
end
