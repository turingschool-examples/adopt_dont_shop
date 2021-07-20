require 'rails_helper'

RSpec.describe 'application' do
  it 'displays a link to all pets' do
    visit '/'
    expect(page).to have_content("Adopt, don't shop!")
    expect(page).to have_link("Adopt a Pet")
    click_link("Adopt a Pet")
    expect(page).to have_current_path('/pets')
  end

  it 'displays a link to all shelters' do
    visit '/'

    expect(page).to have_link("View Shelters")
    click_link("View Shelters")
    expect(page).to have_current_path('/shelters')
    expect(page).to have_link("View Shelters")
    expect(page).to have_link("Adopt a Pet")
    expect(page).to have_link("Veterinarians")
    expect(page).to have_link("Veterinary Offices")
  end

  it 'displays a link to all veterinary offices' do
    visit '/'

    expect(page).to have_link("Veterinary Offices")
    click_link("Veterinary Offices")
    expect(page).to have_current_path('/veterinary_offices')
    expect(page).to have_link("View Shelters")
    expect(page).to have_link("Adopt a Pet")
    expect(page).to have_link("Veterinarians")
    expect(page).to have_link("Veterinary Offices")
  end

  it 'displays a link to all veterinarians' do
    visit '/'

    expect(page).to have_link("Veterinarians")
    click_link("Veterinarians")
    expect(page).to have_current_path('/veterinarians')
    expect(page).to have_link("View Shelters")
    expect(page).to have_link("Adopt a Pet")
    expect(page).to have_link("Veterinarians")
    expect(page).to have_link("Veterinary Offices")
  end
end
