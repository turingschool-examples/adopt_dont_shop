require 'rails_helper'

RSpec.describe 'Applications Show Page' do
  it 'displays the applicants attributes' do
    application = Application.create!(name: 'Jenn', address: '123 Water Street, Denver, CO, 80111',
                                      description: 'I like animals!', status: 'In Progress')
    visit '/applications'
    expect(page).to have_content('Jenn')
  end
end
