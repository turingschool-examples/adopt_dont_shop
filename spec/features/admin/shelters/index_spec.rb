require 'rails_helper'

RSpec.describe 'Admin Shelters Index' do

  before(:each) do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
  end

  it 'see all Shelters in the system listed in reverse alphabetical order by name' do
    visit "admin/shelters"
    save_and_open_page

    expect(page).to have_content([@shelter_2, @shelter_3, @shelter_1])
  end

end
