require 'rails_helper'

RSpec.describe 'index redirect' do
  it 'takes a search term and goes to the show page of that application' do
    app = PetApplication.create!(name: 'Liam', street: '155 Main Street', city: 'Phoenix', state: 'AZ', zip: 85_222,
                                 reason: 'Pet friendly, loving home looking for a companion')

    visit '/'
    fill_in 'Application ID', with: "#{app.id}"
    click_on 'Find Application'

    expect(page).to have_current_path("/applications/#{app.id}")
  end
end
