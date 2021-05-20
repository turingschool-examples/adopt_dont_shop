require 'rails_helper'

RSpec.describe 'applications creation' do

describe 'applications new' do
  it 'renders the form for new applications' do
    visit 'applications/new'

    expect(page).to have_content('Apply to Adopt')
    expect(find('form')).to have_content('Name')
    expect(find('form')).to have_content('Street Address')
    expect(find('form')).to have_content('City')
    expect(find('form')).to have_content('State')
    expect(find('form')).to have_content('Zipcode')
    expect(find('form')).to have_content('Why I Would Be a Good Home')

  end
end