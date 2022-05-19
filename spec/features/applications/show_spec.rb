require 'rails_helper'

RSpec.describe 'application' do
  it 'shows full address of applicant' do
    application = Application.create!(name: 'Sylvester Tommy', street_address: '1827 Vincent Ave', city: 'Halifax',
                                      state: 'Colorado', zip_code: '19274', description: 'I LOVE pets', status: 'In Progress')
    visit "/applications/#{application.id}"

    expect(page).to have_content('Sylvester Tommy')
    expect(page).to have_content('1827 Vincent Ave')
    expect(page).to have_content('Halifax')
    expect(page).to have_content('Colorado')
    expect(page).to have_content('19274')
    expect(page).to have_content('I LOVE pets')
    expect(page).to have_content('In Progress')
  end
end
