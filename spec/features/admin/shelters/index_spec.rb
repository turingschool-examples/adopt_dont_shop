require 'rails_helper'

RSpec.describe 'the admin shelters index' do
  it 'lists all the shelters in reverse alphabetical order by name' do
    shelter1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    shelter2 = Shelter.create(name: 'Denver shelter', city: 'Denver, CO', foster_program: true, rank: 10)
    shelter3 = Shelter.create(name: 'Arvada shelter', city: 'Arvada, CO', foster_program: false, rank: 7)
    
    visit '/admin/shelters'

    expect(shelter2.name).to appear_before(shelter1.name)
    expect(shelter1.name).to appear_before(shelter3.name)
  end
end
# As a visitor
# When I visit the admin shelter index ('/admin/shelters')
# Then I see all Shelters in the system listed in reverse alphabetical order by name