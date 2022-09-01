require 'rails_helper'

RSpec.describe 'create a new application', type: :feature do

  it 'has a page with an applicaiton form' do
    visit("/applications/new")

    expect(find('form')).to have_content "Name"
    expect(find('form')).to have_content "Street Address"
    expect(find('form')).to have_content "City"
    expect(find('form')).to have_content "State"
    expect(find('form')).to have_content "Zip Code"
    expect(find('form')).to have_content "Why would you make a good home for these pets?"
    expect(find('form')).to have_content "Submit"
  end

end