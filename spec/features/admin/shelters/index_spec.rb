require 'rails_helper'

RSpec.describe 'admin shelters index page' do
  let(:shelter) { Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9) }
  let(:shelter_2) { Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5) }
  let(:shelter_3) { Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10) }

  describe "#order_by_name"
  it "can see all shelters in the system listed in reverse alphabetical order by name" do
    visit '/admin/shelters'
    save_and_open_page

    expect(current_path).to eq('/admin/shelters')
    expect(shelter.order_by_name)
    expect('RGV animal shelter').to appear_before('Aurora shelter')
    expect('Fancy pets of Colorado').to appear_before('Aurora shelter')
    expect('Aurora shelter').to_not appear_before('RGV animal shelter')
  end
end
