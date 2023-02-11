require 'rails_helper'

RSpec.describe 'applications new page' do
  it 'has a form for a new application' do
    visit '/applications/new'

    expect(page).to have_content("New Application Form")
    expect(page).to have_field('Name')
    expect(page).to have_field('Street Address')
    expect(page).to have_field('City')
    expect(page).to have_field('State')
    expect(page).to have_field('Zip Code:')
    expect(page).to have_field('Why I would make a good home')
    expect(page).to have_button('Submit')
  end

  it 'can take information, post it to the database, and redirect me to the new application show page with content' do
    applicant = Application.create!(name: 'Steve Steveson', 
      street_address: '1800 Steve Ln', 
      city: 'Steveburg', 
      state: 'CO',
      zip_code: 81789, 
      reason_for_adoption: "Because I have a tight house and my name is Steve",
      status: "In Progress"
      )
    visit '/applications/new'

    fill_in 'Name', with: 'Steve Steveson'
    fill_in 'Street Address', with: '1800 Steve Ln'
    fill_in 'City', with: 'Steveburg'
    fill_in 'State', with: 'CO'
    fill_in 'Zip Code', with: '81789'
    fill_in 'Why I would make a good home', with: 'Because I have a tight house and my name is Steve'
    click_on 'Submit'

    expect(page).to have_current_path("/applications/#{applicant.id}")
    expect(page).to have_content('Steve Steveson')
    expect(page).to have_content('1800 Steve Ln')
    expect(page).to have_content('Steveburg')
    expect(page).to have_content('CO')
    expect(page).to have_content('81789')
    expect(page).to have_content('Because I have a tight house and my name is Steve')
    expect(page).to have_content('In Progress')
  end
end