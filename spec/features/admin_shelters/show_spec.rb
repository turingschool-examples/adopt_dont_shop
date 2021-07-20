require 'rails_helper'

RSpec.describe 'the admin shelter show page' do
  it "shows the shelter name and full address" do
    shelter = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)

    visit "/admin/shelters/#{shelter.id}"

    expect(page).to have_content(shelter.name)
    expect(page).to have_content(shelter.city)
  end
end
