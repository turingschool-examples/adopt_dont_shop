require 'rails_helper'

RSpec.describe 'application' do
  it 'displays a link to all pets' do
    visit '/'
    expect(page).to have_content("Adopt, don't shop!")
    expect(page).to have_link('Pets')
    click_link('Pets')
    expect(page).to have_current_path('/pets')
  end

  it 'displays a link to all shelters' do
    visit '/'

    expect(page).to have_link('Shelters')
    click_link('Shelters')
    expect(page).to have_current_path('/shelters')
    expect(page).to have_link('Shelters')
    expect(page).to have_link('Pets')
    expect(page).to have_link('Veterinarians')
    expect(page).to have_link('Veterinary Offices')
  end

  it 'displays a link to all veterinary offices' do
    visit '/'

    expect(page).to have_link('Veterinary Offices')
    click_link('Veterinary Offices')
    expect(page).to have_current_path('/veterinary_offices')
    expect(page).to have_link('Shelters')
    expect(page).to have_link('Pets')
    expect(page).to have_link('Veterinarians')
    expect(page).to have_link('Veterinary Offices')
  end

  it 'displays a link to all veterinarians' do
    visit '/'

    expect(page).to have_link('Veterinarians')
    click_link('Veterinarians')
    expect(page).to have_current_path('/veterinarians')
    expect(page).to have_link('Shelters')
    expect(page).to have_link('Pets')
    expect(page).to have_link('Veterinarians')
    expect(page).to have_link('Veterinary Offices')
  end

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
