require 'rails_helper'

RSpec.describe AdoptingApplication, type: :model do
  describe 'relationships' do
    it { should belong_to(:pets) }
  end

  describe 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name)
    it { should validate_presence_of(:address) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:zipcode) }
    it { should validate_presence_of(:description) }
    it { should validate_numericality_of(:zipcode) }
  end

  before(:each) do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', )
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', )
    @shelter_3 = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', )

    @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: false)
    @pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @pet_3 = @shelter_3.pets.create(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
    @pet_4 = @shelter_1.pets.create(name: 'Ann', breed: 'ragdoll', age: 5, adoptable: true)

    @applicant_1 = @pet_1.applications.create(first_name: 'Austin', last_name: 'Andrade', address: '1345 Bobo Drive',
                                              city: 'Denver', state: 'CO', zipcode: 12345, description: 'It is cute')
    @applicant_2 = @pet_2.applications.create(first_name: 'George', last_name: 'Ho', address: '2213 Springer Ave',
                                              city: 'Boston', state: 'MA', zipcode: 56789, description: 'It is fluffy')
    @applicant_3 = @pet_3.applications.create(first_name: 'Kathy', last_name: 'Ortega', address: '614 Bucky St.',
                                              city: 'Austin', state: 'TX', zipcode: 94678, description: 'I love cats')
end
