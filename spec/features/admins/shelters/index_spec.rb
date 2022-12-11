require 'rails_helper'

RSpec.describe 'admin shelter index' do
  
  
  
  
  
  
  
  
  
  
  
  
  
  it 'lists all shelters in reverse alphabetical order' do
    shelter1 = Shelter.create!(foster_program: true, name: "Doggie Dog World", city: "Denver", rank: 3)
    shelter2 = Shelter.create!(foster_program: true, name: "Endless Pawsabilities", city: "Durango", rank: 1)
    shelter3 = Shelter.create!(foster_program: true, name: "Tail of two Kitties", city: "Seattle", rank: 9)

    visit '/admin/shelters'

    expect(shelter3.name).to appear_before(shelter2.name)
    expect(shelter2.name).to appear_before(shelter1.name)
  end


end