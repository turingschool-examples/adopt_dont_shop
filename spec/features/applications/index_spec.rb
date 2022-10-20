require 'rails_helper'

RSpec.describe 'the application index' do
  before(:each) do
    shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
    @pet_2 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)
  end
  it 'lists all the applications with their attributes' do
    visit "/"
    expect(page).to have_content(@pet_1.name)
    expect(page).to have_content(@pet_2.name)
  end
end