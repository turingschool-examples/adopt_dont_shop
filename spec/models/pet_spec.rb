require 'rails_helper'

RSpec.describe Pet, type: :model do
  describe 'relationships' do
    it { should belong_to(:shelter) }
    it { should have_many(:adopting_applications) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:age) }
    it { should validate_numericality_of(:age) }
  end

  before(:each) do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @pet_1 = @shelter_1.pets.create(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
    @pet_2 = @shelter_1.pets.create(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @pet_3 = @shelter_1.pets.create(name: 'Ann', breed: 'ragdoll', age: 3, adoptable: false)
    # @application_1 = @pet_1.adopting_applications.create(full_name: 'Mike Piz', street_address: '13214 Yeet Rd.',
    #                                             city: 'Cleveland', state: 'OH', zipcode: 18907,
    #                                             description: 'I like this dog. It is very fluffy. Let me have it.',
    #                                             in_progress: true, accepted: false, declined: false)
    # @application_2 = @pet_2.adopting_applications.create(full_name: 'Sam Smith', street_address: '95837 Tomahawk Dr.',
    #                                             city: 'Cincinatti', state: 'OH', zipcode: 44567 ,
    #                                             description: 'I have been a big fan of birds since I was a child. I would like to adopt this little guy so I can have a friend.',
    #                                             in_progress: false, accepted: true, declined: false)
  end

  describe 'class methods' do
    describe '#search' do
      it 'returns partial matches' do
        expect(Pet.search("Claw")).to eq([@pet_2])
      end
    end

    describe '#adoptable' do
      it 'returns adoptable pets' do
        expect(Pet.adoptable).to eq([@pet_1, @pet_2])
      end
    end
  end

  describe 'instance methods' do
    describe '.shelter_name' do
      it 'returns the shelter name for the given pet' do
        expect(@pet_3.shelter_name).to eq(@shelter_1.name)
      end
    end
  end
end
