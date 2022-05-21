require 'rails_helper'

RSpec.describe 'the admin shelters index page' do
  it 'shows all shelters in the system in reverse alphabetical order' do
    shelter1 = Shelter.create!(foster_program: true, name: 'Gally', city: 'Denver', rank: 21)
    shelter2 = Shelter.create!(foster_program: true, name: 'Fally', city: 'Denver', rank: 21)
    shelter3 = Shelter.create!(foster_program: true, name: 'Eally', city: 'Denver', rank: 21)
    shelter4 = Shelter.create!(foster_program: true, name: 'Dally', city: 'Denver', rank: 21)

    visit '/admin/shelters'

    expect(shelter1.name).to appear_before(shelter2.name)

    expect(shelter1.name).to appear_before(shelter4.name)

    expect(shelter1.name).to appear_before(shelter3.name)

    expect(shelter3.name).to appear_before(shelter4.name)

    expect(shelter2.name).to appear_before(shelter4.name)

    expect(shelter4.name).to_not appear_before(shelter2.name)
  end
end
