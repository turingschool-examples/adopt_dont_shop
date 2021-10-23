require 'rails_helper'

RSpec.describe 'Applications New' do
  it 'provides a link to start an application' do
    visit "/applications/new"

    expect(page).to have_content("Name")
    expect(page).to have_content("Street Address")
  end
end
