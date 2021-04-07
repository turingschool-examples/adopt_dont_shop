require 'rails_helper'

RSpec.describe ApplicationsPet, type: :model do
  describe 'relationships' do
    it { should belong_to(:pet) }
    it { should belong_to(:application) }
  end

  describe 'validations' do
    it { should validate_presence_of(:application_id) }
    it { should validate_numericality_of(:application_id) }
    it { should validate_presence_of(:pet_id) }
    it { should validate_numericality_of(:pet_id) }
  end

  before(:each) do
    @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
    @shelter_3 = Shelter.create(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: true, rank: 10)

    @pet_1 = @shelter_1.pets.create!(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: false)
    @pet_2 = @shelter_1.pets.create!(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
    @pet_3 = @shelter_3.pets.create!(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)

    @user_1 = User.create!(full_name: 'Mike Piz', street_address: '13214 Yeet Rd.', city: 'Cleveland', state: 'OH', zipcode: 18907)
    @user_2 = User.create!(full_name: 'Yo Lo', street_address: '95837 Tomahawk Dr.', city: 'Cincinatti', state: 'OH', zipcode: 44567)
    @user_3 = User.create!(full_name: 'Sam Smith', street_address: '34573 Board Rd.', city: 'Austin', state: 'TX', zipcode: 67875 )

    @application_1 = Application.create!(status: 'yessir', description: 'give me the damn dog', user_id: @user_1.id)
    @application_2 = Application.create!(status: 'yessir', description: 'give me the damn dog', user_id: @user_2.id)
    @application_3 = Application.create!(status: 'yessir', description: 'give me the damn dog', user_id: @user_3.id)

    @association_1 = ApplicationsPet.create!(pet_id: @pet_1.id, application_id: @application_1.id )
    @association_2 = ApplicationsPet.create!(pet_id: @pet_2.id, status: "Pending", application_id: @application_2.id )
    @association_3 = ApplicationsPet.create!(pet_id: @pet_3.id, status: "Accepted", application_id: @application_3.id )
    @association_4 = ApplicationsPet.create!(pet_id: @pet_3.id, status: "Rejected", application_id: @application_3.id )

  end

  describe 'class methods' do
    describe '#accepted' do
      it 'returns accepted applications' do
        expect(ApplicationsPet.accepted).to eq([@association_3])
      end
    end

    describe '#in_progress' do
      it 'returns in_progress applications' do
        expect(ApplicationsPet.in_progress).to eq([@association_1])
      end
    end

    describe '#rejected' do
      it 'returns rejected applications' do
        expect(ApplicationsPet.rejected).to eq([@association_4])
      end
    end

    describe '#pending' do
      it 'returns pending applications' do
        expect(ApplicationsPet.pending).to eq([@association_2])
      end
    end
  end

  describe 'instance methods' do
    describe '.pet_name' do
      it 'returns the pet name for the given application' do
        expect(@association_3.pet_name).to eq(@pet_3.name)
      end
    end

    describe 'user_name' do
      it 'returns the users name for the given application' do
        expect(@association_1.application.user_name).to eq(@user_1.full_name)
      end
    end
  end
end
