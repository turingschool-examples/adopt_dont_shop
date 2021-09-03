require 'rails_helper'

RSpec.describe 'the app show page' do
  it 'shows an applicants personal info' do
    shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
    pet_2 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)

    app_1 = App.create!(name: "Cindy Lou Who", address: "123n/Some Streetn/Chicago, IL 12345", description: "I'm a who for crying out loud.", status: "In Progress")

    binding.pry

  end
end
