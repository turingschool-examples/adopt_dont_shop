require 'rails_helper'

RSpec.describe "application", type: :feature do
  it 'takes to new application form' do
    visit '/pets'

    expect(page).to have_link("Start an Application")
    click_link "Start an Application"

    expect(current_path).to eq('/applications/new')
    expect(page).to have_content("Name:")
  end
end
