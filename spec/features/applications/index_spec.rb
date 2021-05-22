require 'rails_helper'

RSpec.describe 'applications index' do
  context 'links' do
    it 'has a link to start an application' do
      visit '/applications'

      expect(page).to have_content("Start an Application")

      click_link 'Start an Application'

      expect(current_path).to have_content('/applications/new')
    end
  end
end
