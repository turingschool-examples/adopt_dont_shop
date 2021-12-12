require 'rails_helper'

RSpec.describe 'admin shelts index page' do
  it 'lists all shelters in reverse alphabetical order by name' do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    visit "/admin/shelters"
    actual = page.find_all('.shelter').map(&:text).join
    expected = [@shelter_2.name, @shelter_3.name, @shelter_1.name].join(" ")
    

    expect(actual).to eq(expected)
  end
end
