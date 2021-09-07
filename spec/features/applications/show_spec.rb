require 'rails_helper'

RSpec.describe 'the application show' do
  it "shows the application and its attributes" do

    application = Application.create(name: 'Matt Holmes', address: 123, street: 'Pwahoo Ln', city: 'Arvada', state: 'CO', zip_code: '80001', status: 'Pending', description: 'I like dogs')

    visit "/applications/#{application.id}"

    expect(current_path).to eq( "/applications/#{application.id}")

    expect(page).to have_content('Matt Holmes')
    expect(page).to have_content(123)
    expect(page).to have_content('Pwahoo Ln')
    expect(page).to have_content('CO')
    expect(page).to have_content('Arvada')
  end
end
