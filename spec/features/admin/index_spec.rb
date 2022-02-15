require 'rails_helper'

RSpec.describe 'admin index' do
  before(:each) do
    @aurora = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @cherry_creek = Shelter.create(name: 'Cherry Creek shelter', city: 'Denver, CO', foster_program: true, rank: 1)
    @denver = Shelter.create(name: 'Denver shelter', city: 'Denver, CO', foster_program: true, rank: 5)
  end

  it 'lists all shelters alphabetically' do
    visit "/admin/shelters"

    within ('#shelters') do
      expect(page.all('.shelter')[0]).to have_content('Aurora shelter')
      expect(page.all('.shelter')[1]).to have_content("Cherry Creek shelter")
      expect(page.all('.shelter')[2]).to have_content("Denver shelter")
    end
  end
end
