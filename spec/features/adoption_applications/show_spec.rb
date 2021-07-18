require 'rails_helper'

RSpec.describe 'Adoption application show page' do
  it 'shows the adoption application and all its attributes' do
    adopt_app1 = AdoptionApplication.create!(
      name: 'Michael Abbott',
      street_address: '66 Bell St.',
      city: 'Seattle',
      state: 'Wa',
      zip_code: '98121',
      status: 'In Progress'
    )
    visit "/adoption_applications/#{adopt_app1.id}"

    expect(page).to have_content(adopt_app1.name)
    expect(page).to have_content(adopt_app1.street_address)
    expect(page).to have_content(adopt_app1.city)
    expect(page).to have_content(adopt_app1.state)
    expect(page).to have_content(adopt_app1.zip_code)
    expect(page).to have_content('Pets to adopt:')
    expect(page).to have_content(adopt_app1.description)
    expect(page).to have_content('Status: In Progress')
  end
end
