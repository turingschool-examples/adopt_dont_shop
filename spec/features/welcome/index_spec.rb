require 'rails_helper'

RSpec.describe 'Welcome Index' do
  it 'displays a link to all pets' do
    visit '/'
    expect(page).to have_content("Adopt, Don't Shop!")
    expect(page).to have_link("Pets")
    click_link("Pets")
    expect(page).to have_current_path('/pets')
  end

  it 'displays a link to all shelters' do
    visit '/'

    expect(page).to have_link("Shelters")
    click_link("Shelters")
    expect(page).to have_current_path('/shelters')
    expect(page).to have_link("Shelters")
    expect(page).to have_link("Pets")
  end

  it 'displays a link to all applications' do
    visit '/'

    expect(page).to have_link("Applications")
    click_link("Applications")
    expect(page).to have_current_path('/applications')
    expect(page).to have_link("Shelters")
    expect(page).to have_link("Pets")
  end
end
