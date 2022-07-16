require 'rails_helper' 

RSpec.describe 'the admin shelters index' do 

    it 'lists Shelters in reverse alphabetical order when visited by admin' do
        shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
        shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
        shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
        shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
        shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
        shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)

        visit '/admin/shelters' 

        expect('RGV animal shelter').to appear_before('Fancy pets of Colorado')
        expect('Fancy pets of Colorado').to appear_before('Aurora shelter')
    end
end

