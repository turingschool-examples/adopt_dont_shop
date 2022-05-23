require 'rails_helper'

describe 'the admin application show page', type: :feature do
  let!(:shelter_1) {Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)}
  let!(:shelter_2) {Shelter.create!(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)}
  let!(:shelter_3) {Shelter.create!(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)}

  it "lists all shelters in reverse alphabetical order" do
    visit '/admin/shelters'

    expect('RGV animal shelter').to appear_before('Fancy pets of Colorado')
    expect('Fancy pets of Colorado').to appear_before('Aurora shelter')
  end

end
