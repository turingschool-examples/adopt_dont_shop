require 'rails_helper'

RSpec.describe 'the applications new page' do
  it 'links you to a new application page from pet index' do

    visit "/pets"

    click_on "Start an Adoption Application"

    expect(current_path).to eq("/applications/new")
  end

end
