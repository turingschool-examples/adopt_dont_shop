require 'rails_helper'

RSpec.describe 'admin shelter index page' do
  it 'displays all shelters in reverse alphabetical order by name' do
    mystery = Shelter.create!(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    aurora = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    hollywood = Shelter.create!(name: 'Hollywood shelter', city: 'Irvine, CA', foster_program: false, rank: 7)
    rgv = Shelter.create!(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)

    visit '/admin/shelters'

    expect(page).to have_content(mystery.name)

    within ("#shelter") do
      expect(page.all('.shelters')[0]).to have_content(rgv.name)
      expect(page.all('.shelters')[1]).to have_content(mystery.name)
      expect(page.all('.shelters')[2]).to have_content(hollywood.name)
      expect(page.all('.shelters')[3]).to have_content(aurora.name)
    end
  end
end