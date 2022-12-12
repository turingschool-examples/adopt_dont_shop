require 'rails_helper' 

RSpec.describe 'admin shelter index' do

  it 'lists all shelters in reverse alphabetical order' do
    shelter1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    shelter2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    shelter3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)

    visit '/admin/shelters'
    save_and_open_page
    expect(shelter2.name).to appear_before(shelter3.name)
    expect(shelter3.name).to appear_before(shelter1.name)
  end
end
