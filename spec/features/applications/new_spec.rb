require 'rails_helper'

RSpec.describe 'new application page' do
  it 'links to the new page from the pets index page' do
    visit '/pets'

    click_link 'Start an Application'
    expect(current_path).to eq('/applications/new')
  end
end