require 'rails_helper'

RSpec.describe AdoptingApplication, type: :model do
  describe 'relationships' do
    it { should belong_to(:pet) }
  end

  describe 'validations' do
    it { should validate_presence_of(:full_name) }
    it { should validate_presence_of(:street_address) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:zipcode) }
    it { should validate_numericality_of(:zipcode) }
  end

  before(:each) do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: true, rank: 10)

    @pet_1 = @shelter_1.pets.create!(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: false)
    @pet_2 = @shelter_1.pets.create!(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @pet_3 = @shelter_3.pets.create!(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
    @pet_4 = @shelter_1.pets.create!(name: 'Ann', breed: 'ragdoll', age: 5, adoptable: true)

    @applicant_1 = @pet_1.adopting_applications.create(
      full_name: 'Mike Piz', street_address: '13214 Yeet Rd.',
      city: 'Cleveland', state: 'OH', zipcode: 18907,
      description: 'I like this dog. It is very fluffy. Let me have it.',
      in_progress: true, accepted: false, declined: false, pending: false)
    @applicant_2 = @pet_2.adopting_applications.create(
      full_name: 'Sam Smith', street_address: '95837 Tomahawk Dr.',
      city: 'Cincinatti', state: 'OH', zipcode: 44567 ,
      description: 'I have been a big fan of birds since I was a child. I would like to adopt this little guy so I can have a friend.',
      in_progress: false, accepted: true, declined: true, pending: false)
    @applicant_3 = @pet_3.adopting_applications.create(
      full_name: 'Yo Lo', street_address: '34573 Board Rd.',
      city: 'Austin', state: 'TX', zipcode: 67875,
      description: 'I have 25 cats. Another one wouldnt hurt',
      in_progress: true, accepted: false, declined: false, pending: true)
  end

  describe 'class methods' do
    describe '#accepted' do
      it 'returns accepted applications' do
        expect(AdoptingApplication.accepted).to eq([@applicant_2])
      end
    end

    describe '#in_progress' do
      it 'returns in_progress applications' do
        expect(AdoptingApplication.in_progress).to eq([@applicant_1, @applicant_3])
      end
    end

    describe '#declined' do
      it 'returns declined applications' do
        expect(AdoptingApplication.declined).to eq([@applicant_2])
      end
    end

    describe '#pending' do
      it 'returns pending applications' do
        expect(AdoptingApplication.pending).to eq([@applicant_3])
      end
    end
  end

  describe 'instance methods' do
    describe '.pet_name' do
      it 'returns the pet name for the given applicant' do
        expect(@applicant_3.pet_name).to eq(@pet_3.name)
      end
    end
  end
end
