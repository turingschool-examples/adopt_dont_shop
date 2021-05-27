require 'rails_helper'

describe 'admin shelters show' do
  before :each do
    @shelter = Shelter.create!(foster_program: true, name: "Aurora Pet Home", city: "Aurora, CO", rank:5)
    visit "/admin/shelters/#{@shelter.id}"
  end

  it 'displays the name and full address of the shelter' do
    expect(page).to have_content('Shelter Name: Aurora Pet Home')
    expect(page).to have_content('Shelter Location: Aurora, CO')
  end
end