require 'rails_helper'

RSpec.describe 'the Admin Shelters Index' do
  before(:each) do
    @shelter1 =Shelter.create!(name:'Detroit Human People', city:'Detroit', foster_program:true, rank: 6)
    @shelter2 =Shelter.create!(name:'Another Shelter', city:'Las Angeles', foster_program:true, rank: 7)
    @shelter3 =Shelter.create!(name:'a shelter', city:'Denver', foster_program:false, rank: 3)
    @shelter6=Shelter.create!(name:'Marquette Humane Society', city:'Marquette', foster_program:true, rank: 1)
    @shelter7=Shelter.create!(name:'San Antonio Humane Society', city:'San Antonio', foster_program:true, rank: 2)

    visit '/admin/shelters'
  end
  # Story 10
  # When I visit the admin shelter index ('/admin/shelters')
  # Then I see all Shelters in the system listed in reverse alphabetical order by name

  it 'shows all of the shelters in reverse order' do
    expect(@shelter2).to appear_before(@shelter3)
    expect(@shelter2).to appear_before(@shelter1)
    expect(@shelter3).to appear_before(@shelter1)
  end
end