require 'rails_helper'

RSpec.describe 'admin_shelters index page' do
  before :each do
    @application = create(:application)
    @shelter_1   = create(:shelter)
  end
  it 'displays the name of all the shelters in reverse alphabetical order' do
    visit "/admin/shelters"

    expect(page).to have_content()
    expect(page).to_not have_content()
  end
end