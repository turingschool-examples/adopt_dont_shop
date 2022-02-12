require 'rails_helper'

RSpec.describe 'New applicant' do
  before (:each) do
    @greg = Applicant.create!(name: 'Greg Flaherty', street_address: '123 MyStreet St.', city: "Dallas", state: "TX", zipcode: '12345', description: "Love dogs", status: "In progress")
    @no_dog_left_behind = Shelter.create!(name: 'No Dog Left Behind', rank: 1, foster_program: true, city: 'Dallas')
    @jax = @no_dog_left_behind.pets.create!(name: "Jax", age: 1, breed: 'Golden Retriever', adoptable: true)
  end
  it "starts an application from pet index page" do

    visit "/pets/"

    expect(page).to have_link("Start an Application")
  end

  it "clicking on link takes you to new application" do

    visit "/pets/"

    click_on "Start an Application"
    expect(current_path).to eq("/applicants/new")

    expect(page).to have_content('New Application')
    expect(find('form')).to have_content('Name:')
    expect(find('form')).to have_content('Street Address:')
    expect(find('form')).to have_content('City:')
    expect(find('form')).to have_content('State:')
    expect(find('form')).to have_content('Zipcode:')
    expect(find('form')).to have_content('Description:')
  end

  it 'creates the application' do
    visit '/applicants/new'

    fill_in 'Name:', with: 'Laura Guerra'
    fill_in 'Street Address:', with: '987 Her Rd.'
    fill_in 'City:', with: 'Miami'
    fill_in 'State:', with: "FL"
    fill_in 'Zipcode:', with: "11111"
    fill_in 'Description:', with: "I love dogs"
    click_button 'Submit Application'

    expect(page).to have_content('Laura Guerra')
    expect(page).to have_content('In Progress')
  end

  it 'requires certain entries in the application' do
    visit '/applicants/new'

    fill_in 'Street Address:', with: '987 Her Rd.'
    fill_in 'City:', with: 'Miami'

    click_button 'Submit Application'
    save_and_open_page
    expect(page).to have_content("Error: Name can't be blank, State can't be blank, Zipcode can't be blank")
    expect(page).to have_current_path('/applicants/new')
  end
end
