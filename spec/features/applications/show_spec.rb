require 'rails_helper'

RSpec.describe 'the application show' do
  let!(:app1){Application.create(name: 'Stephen', street_address: '3 Green St', city: 'Boulder', state: 'CO', zip_code: 80303, description: 'Combat loneliness' )}
  it "shows the application and all it's attributes" do
    visit "/applications/#{app1.id}"

    expect(page).to have_content('Stephen')
    expect(page).to have_content('3 Green St')
    expect(page).to have_content('Boulder')
    expect(page).to have_content('CO')
    expect(page).to have_content(80303)
    expect(page).to have_content('Combat loneliness')
    save_and_open_page
  end
end
