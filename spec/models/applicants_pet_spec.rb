require 'rails_helper'

RSpec.describe ApplicantsPet, type: :model do
  describe 'relationships' do
    it { should belong_to(:pet) }
    it { should belong_to(:applicant) }
  end

  describe 'validations' do
    it { should validate_presence_of(:pet_id) }
    it { should validate_numericality_of(:pet_id) }
    it { should validate_presence_of(:applicant_id) }
    it { should validate_numericality_of(:applicant_id) }
    it { should validate_presence_of(:description) }
  end

  before(:each) do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: true, rank: 10)

    @pet_1 = @shelter_1.pets.create!(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: false)
    @pet_2 = @shelter_1.pets.create!(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @pet_3 = @shelter_3.pets.create!(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)

    @applicant_1 = Applicant.create!(full_name: 'Mike Piz', street_address: '13214 Yeet Rd.', city: 'Cleveland', state: 'OH', zipcode: 18907)
    @applicant_2 = Applicant.create!(full_name: 'Yo Lo', street_address: '95837 Tomahawk Dr.', city: 'Cincinatti', state: 'OH', zipcode: 44567)
    @applicant_3 = Applicant.create!(full_name: 'Sam Smith', street_address: '34573 Board Rd.', city: 'Austin', state: 'TX', zipcode: 67875 )

    @association_1 = ApplicantsPet.create!(description: 'blah', pet_id: @pet_1.id, applicant_id: @applicant_1.id )
    @association_2 = ApplicantsPet.create!(description: 'aer', pet_id: @pet_2.id, status: "Pending", applicant_id: @applicant_2.id )
    @association_3 = ApplicantsPet.create!(description: 'TBD', pet_id: @pet_3.id, status: "Accepted", applicant_id: @applicant_3.id )
    @association_4 = ApplicantsPet.create!(description: 'TBD', pet_id: @pet_3.id, status: "Rejected", applicant_id: @applicant_3.id )

  end

  describe 'class methods' do
    describe '#accepted' do
      it 'returns accepted applications' do
        expect(ApplicantsPet.accepted).to eq([@association_3])
      end
    end

    describe '#in_progress' do
      it 'returns in_progress applications' do
        expect(ApplicantsPet.in_progress).to eq([@association_1])
      end
    end

    describe '#rejected' do
      it 'returns rejected applications' do
        expect(ApplicantsPet.rejected).to eq([@association_4])
      end
    end

    describe '#pending' do
      it 'returns pending applications' do
        expect(ApplicantsPet.pending).to eq([@association_2])
      end
    end
  end

  describe 'instance methods' do
    describe '.pet_name' do
      it 'returns the pet name for the given application' do
        expect(@association_3.pet_name).to eq(@pet_3.name)
      end
    end

    describe '.applicant_name' do
      it 'returns the applicant name for the given application' do
        expect(@association_1.applicant_name).to eq(@applicant_1.full_name)
      end
    end
  end
end
