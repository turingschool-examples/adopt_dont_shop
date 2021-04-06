require 'rails_helper'

RSpec.describe 'applications index page' do
  it 'shows a link to start an application' do
    visit '/applications'

    expect(page).to have_link("Start an Application", href: applications_new_path)
  end
end