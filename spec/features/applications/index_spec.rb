require 'rails_helper'

RSpec.describe 'Applications Index' do
  it 'displays an index of all applications' do
    app1 = Application.create({
      name: 'Chaz Simons',
      street_address: '1234 Cool Guy Rd',
      city: 'Las Vegas',
      state: 'NV',
      zip_code: 89106,
      good_fit: '',
      status: 'In Progress'
      })
    app2 = Application.create({
      name: 'Justina Hortizuela',
      street_address: '1313 Addams Dr',
      city: 'Las Vegas',
      state: 'NV',
      zip_code: 89148,
      good_fit: '',
      status: 'In Progress'
      })
    visit "/applications"

    expect(page).to have_content(app1.name)
    expect(page).to have_content(app2.name)
  end
end
