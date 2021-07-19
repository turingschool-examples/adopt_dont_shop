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
  #SQL Only Story
  # When I visit the admin shelter index ('/admin/shelters')
  # Then I see all Shelters in the system listed in reverse alphabetical order by name

  it 'shows all of the shelters in reverse order' do
    expect(@shelter2).to appear_before(@shelter3)
    expect(@shelter2).to appear_before(@shelter1)
    expect(@shelter3).to appear_before(@shelter1)
  end

  # Story 11
  # When I visit the admin shelter index ('/admin/shelters')
  # Then I see a section for "Shelter's with Pending Applications"
  # And in this section I see the name of every shelter that has a pending application
  it 'has a section with the shelters that have pending apps' do
    @pet1 = Pet.create(name:'Muffin',adoptable:true,breed:'fluffy cat',age:5, shelter_id: @shelter6.id, pic:'20210429_144443.jpg')
    @pet2 = Pet.create(name:'Tesla',adoptable:true,breed:'hunter cat',age:4, shelter_id: @shelter7.id, pic:'tesla.jpg')
    @pet3 = Pet.create(name:'Cosmos',adoptable:true,breed:'playful cat',age:4, shelter_id: @shelter7.id, pic:'20210429_144443.jpg')
    app = Applicant.create(name: 'Scooby', street: "123", city:"fake", state: "fake", zip: 48248)
    PetApp.create(pet_id: @pet1.id applicant_id: app.id)
    PetApp.create(pet_id: @pet3.id applicant_id: app.id)
    PetApp.create(pet_id: @pet2.id applicant_id: app.id)

    within('div#pending') do
      expect(page).to have_content(@shelter6.name)
      expect(page).to have_content(@shelter7.name)
      expect(page).to_not have_content(@shelter1.name)
      expect(page).to_not have_content(@shelter2.name)
      expect(page).to_not have_content(@shelter3.name)
      expect(page).to_not have_content(@shelter4.name)
      expect(page).to_not have_content(@shelter5.name)
    end

  end
end