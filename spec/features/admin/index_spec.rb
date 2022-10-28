require 'rails_helper'

RSpec.describe 'Admin Index' do
  before(:each) do
    visit "/admins"
  end
  describe 'When I visit /admins' do
    describe 'Then I see' do
      it 'link to /admins/shelters and /admins/applications' do
        visit "/admins"

        expect(page).to have_link("Applications")
        expect(page).to have_link("Shelters")
      end
    end
  end
end