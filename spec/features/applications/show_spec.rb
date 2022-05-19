require 'rails_helper'

RSpec.describe 'Applications Show Page' do
  it 'displays the applicants attributes' do
    application = Application.create!(name: 'Jenn', address: '123 Water Street, Denver, CO, 80111',
                                      description: 'I like animals!', status: 'In Progress')
    visit "/applications/#{application.id}"
    save_and_open_page
    expect(page).to have_content('Jenn')
    expect(page).to have_content('123 Water Street, Denver, CO, 80111')
    expect(page).to have_content('I like animals!')
    expect(page).to have_content('In Progress')
  end
end
