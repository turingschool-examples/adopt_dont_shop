require 'rails_helper'

RSpec.describe 'application creation' do
  it 'has a link to Start and Application' do
    visit "/pets"

    click_on "Start an Application"

    expect(current_path).to eq("/applications/new")
  end

  it 'takes me to a form to complete a new application' do # this could be nested in the other test?
    visit "/applications/new"

    fill_in(:name, with: "John Deere")
    fill_in(:street_address, with: "5678 Colorado Road")
    fill_in(:city, with: "Denver")
    fill_in(:state, with: "Colorado")
    fill_in(:zip, with: "80120")
    fill_in(:description, with: "Cuz sooooo fwuffy")
    click_button "Submit"

    # expect(current_path).to eq("/applications/:id")
    expect(page).to have_content("John Deere")
    expect(page).to have_content("In Progress")
    expect(page).to_not have_content("Rejected")
    expect(page).to_not have_content("Pending")
    expect(page).to_not have_content("Accepted")
  end

  it 'prevents the user from submitting an incomplete form, and redirects back to the new form' do
    visit "/applications/new"

    fill_in(:name, with: "John Deere")
    fill_in(:street_address, with: "5678 Colorado Road")
    fill_in(:city, with: "Denver")
    fill_in(:state, with: "Colorado")
    fill_in(:zip, with: "80120")
    # fill_in(:description, with: "Cuz sooooo fwuffy")
    click_button "Submit"

    expect(current_path).to eq("/applications/new")

    fill_in(:name, with: "John Deere")
    fill_in(:street_address, with: "5678 Colorado Road")
    fill_in(:city, with: "Denver")
    fill_in(:state, with: "Colorado")
    fill_in(:zip, with: "80120")
    fill_in(:description, with: "Cuz sooooo fwuffy")
    click_button "Submit"

    expect(page).to have_content("John Deere")
    expect(page).to have_content("5678 Colorado Road")
    expect(page).to have_content("Denver")
    expect(page).to have_content("Colorado")
    expect(page).to have_content("80120")
    expect(page).to have_content("Cuz sooooo fwuffy")
    expect(page).to have_content("In Progress")
    expect(page).to_not have_content("Rejected")
    expect(page).to_not have_content("Pending")
    expect(page).to_not have_content("Accepted")
  end

  it 'show an error message that you must fill in those blanks' do
    visit "/applications/new"

    fill_in(:name, with: "John Deere")
    fill_in(:street_address, with: "5678 Colorado Road")
    fill_in(:city, with: "Denver")
    fill_in(:state, with: "Colorado")
    fill_in(:zip, with: "80120")
    # fill_in(:description, with: "Cuz sooooo fwuffy")
    click_button "Submit"

    expect(current_path).to eq("/applications/new")
    expect(page).to have_content("Error: Description can't be blank")
  end


end
