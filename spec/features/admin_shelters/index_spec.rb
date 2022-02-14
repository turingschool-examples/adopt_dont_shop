require 'rails_helper'
RSpec.describe 'the admin shelters index' do
  before :each do
    @shelter_1 = Shelter.create!(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create!(name: 'Happy Adoptions', city: 'Stone Mtn GA', foster_program: true, rank: 1)
    @shelter_3 = Shelter.create!(name: 'Doggy World', city: 'Baltimore MD', foster_program: true, rank: 3)
    @shelter_4 = Shelter.create!(name: 'Forever Home', city: 'Brooklyn NY', foster_program: false, rank: 5)

    @scooby = Pet.create!(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: @shelter_1.id)
    @daisy = Pet.create!(name: 'Daisy', age: 4, breed: 'Poodle', adoptable: true, shelter_id: @shelter_1.id)
    @artimus = Pet.create!(name: 'Artimus', age: 7, breed: 'Mut', adoptable: true, shelter_id: @shelter_2.id)
    @apollo = Pet.create!(name: 'Apollo', age: 2, breed: 'Lab', adoptable: true, shelter_id: @shelter_2.id)
    @scruffy = Pet.create!(name: 'Scruffy', age: 3, breed: 'Hot Dog', adoptable: true, shelter_id: @shelter_3.id)
    @pineapple = Pet.create!(name: 'Pineapple', age: 4, breed: 'Cold Dog', adoptable: true, shelter_id: @shelter_3.id)
    @mango = Pet.create!(name: 'Mango', age: 9, breed: 'Fancy Dog', adoptable: true, shelter_id: @shelter_4.id)
    @onion = Pet.create!(name: 'Onion', age: 1, breed: 'Sad Dog', adoptable: true, shelter_id: @shelter_4.id)
    @peach = Pet.create!(name: 'Peach', age: 12, breed: 'Poodle', adoptable: true, shelter_id: @shelter_4.id)
  end

  it 'Shelters in the system listed in reverse alphabetical order by name ' do
    visit '/admin/shelters'
  
    expect(@shelter_1.name).to appear_before(@shelter_2.name)
    expect(@shelter_2.name).to appear_before(@shelter_4.name)
    expect(@shelter_4.name).to appear_before(@shelter_3.name)

  end
end
