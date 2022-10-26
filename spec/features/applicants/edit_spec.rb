require 'rails_helper'

RSpec.describe 'applicant edit page' do
  before(:each) do
    @applicant1 = Applicant.create!(name: "Judgy Judy", street_address: "666 Elm St", city: "New Jersey", state: "NJ", zip: "8675309", status: 'In Progress')
  end

  it 'links from the applicant show page' do
    visit "/applicants/#{@applicant1.id}"
    
    expect(page).to have_button('Edit Applicant')

    click_button 'Edit Applicant'

    expect(current_path).to eq("/applicants/#{@applicant1.id}/edit")
  end

  it 'updates applicant info' do 
    visit "/applicants/#{@applicant1.id}/edit"

    fill_in 'Name', with: 'Judge Judy'
    fill_in "street_address", with:"666 Elm st"
    fill_in "city", with:"New Jersey"
    fill_in "state", with:"New Jersey"
    fill_in "zip", with:"8675309"

    click_button 'Submit'

    expect(current_path).to eq("/applicants/#{@applicant1.id}")
    expect(page).to have_content('Judge Judy')
    expect(page).to_not have_content('Judgy Judy')
  end
end