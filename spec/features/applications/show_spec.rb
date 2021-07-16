require 'rails_helper'

RSpec.describe 'application show page' do
  it 'shows all applicant information' do
    application = create(:application)

    visit "/application/#{application.id}"

    expect(page).to have_content(application.name)
    expect(page).to have_content(application.street)
  end
end
