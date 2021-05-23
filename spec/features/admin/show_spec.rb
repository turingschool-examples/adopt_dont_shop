# spec/features/admin/show_spec

require 'rails_helper'

RSpec.describe 'the admin show' do
  before(:each) do
    @shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
  end

  it 'shows shelter and its attributes' do
    visit "/admin/shelters/#{@shelter.id}"
  
    expect(page).to have_content(@shelter.name)
    expect(page).to have_content(@shelter.city)
  end
end