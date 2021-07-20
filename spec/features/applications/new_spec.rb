require 'rails_helper'

RSpec.describe "the application creation page" do
  it "shows the application and all its attributes" do
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
    click_button('Submit')

    new_application = Application.last

    expect(current_path).to eq("/applications/#{new_application.id}")
    expect(page).to have_content(new_application.name)
    expect(page).to have_content("Address: #{new_application.street} #{new_application.city}, #{new_application.state} #{new_application.zip_code}")
    expect(page).to have_content("Status: In Progress")
  end

  it 'displays an error message when user fails to fill in all form fields' do
    # Starting an Application, Form not Completed
    #
    # As a visitor
    # When I visit the new application page
    # And I fail to fill in any of the form fields
    # And I click submit
    # Then I am taken back to the new applications page
    # And I see a message that I must fill in those fields.
    visit ("/pets")

    click_link("Start an Application")

    expect(current_path).to eq("/applications/new")

    fill_in('name', with: '')
    fill_in('street', with: '')
    fill_in('city', with: '')
    fill_in('state', with: '')
    fill_in('zip_code', with: '')
    click_button('Submit')

    expect(current_path).to eq("/applications/new")
    expect(page).to have_content("Error(s): Name can't be blank")
    expect(page).to have_content("City can't be blank")
    expect(page).to have_content("State can't be blank")
    expect(page).to have_content("Zip code can't be blank")
  end

  it 'display an error message if zip code is not 5 numbers' do
    visit ("/pets")

    click_link("Start an Application")

    expect(current_path).to eq("/applications/new")

    fill_in('name', with: 'Shane McCutchen')
    fill_in('street', with: '1234 Pine Ave')
    fill_in('city', with: 'Arvada')
    fill_in('state', with: 'CO')
    fill_in('zip_code', with: '8021')
    click_button('Submit')

    expect(current_path).to eq("/applications/new")
    expect(page).to have_content("Error(s): Zip code number must be 5 digits long")

    visit ("/pets")

    click_link("Start an Application")

    expect(current_path).to eq("/applications/new")

    fill_in('name', with: 'Shane McCutchen')
    fill_in('street', with: '1234 Pine Ave')
    fill_in('city', with: 'Arvada')
    fill_in('state', with: 'CO')
    fill_in('zip_code', with: '802111')
    click_button('Submit')

    expect(current_path).to eq("/applications/new")
    expect(page).to have_content("Error(s): Zip code number must be 5 digits long")
  end
end
