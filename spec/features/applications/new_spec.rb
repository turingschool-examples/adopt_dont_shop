require "rails_helper"

RSpec.describe "creating a new application" do
  it 'the pet index page has a link to start an application' do
    visit "/pets"

    expect(page).to have_link("Start an Application")

    click_link "Start an Application"

    expect(current_path).to eq("/applications/new")
    have_selector("form")

    fill_in :name, with: "James White"
    fill_in :street_address, with: "4512 Blue Bird Ct"
    fill_in :city, with: "Bend"
    select "OR", from: :state
    fill_in :zip, with: 77904

    click_on "Submit"

    application = Application.last

    expect(current_path).to eq("/applications/#{application.id}") 
    expect(page).to have_content(application.name)
    expect(page).to have_content(application.street_address)
    expect(page).to have_content(application.city)
    expect(page).to have_content(application.state)
    expect(page).to have_content(application.zip)
    expect(page).to have_content("In Progress")
  end

  it 'will not create a new application when fields are left blank and will redirect back 
    to the new application page with a message to fill out incomplete fields' do
      visit "/applications/new"
      have_selector("form")

      fill_in :street_address, with: "4512 Blue Bird Ct"

      click_on "Submit"
      
      expect(current_path).to eq("/applications/new") 
      expect(page).to have_content("Unable to complete your application, please fill out all fields")
      have_selector("form")
  end 
end