require 'rails_helper'

RSpec.describe 'admin shelters show page' do
  it 'contains the shelets name and full address' do
    shelter = Shelter.create(name: 'Mystery Building', street: "123 Main St", city: 'Irvine', state: "CA", zip: "12345", foster_program: false, rank: 9)

    visit "/admin/shelters/#{shelter.id}"

    expect(page).to have_content(shelter.name)
    expect(page).to have_content(shelter.street)
    expect(page).to have_content(shelter.city)
    expect(page).to have_content(shelter.state)
    expect(page).to have_content(shelter.zip)
    expect(page).to_not have_content(shelter.rank)
    expect(page).to_not have_content(shelter.foster_program)
  end
end