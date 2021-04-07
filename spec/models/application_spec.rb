require 'rails_helper'

RSpec.describe Application, type: :model do
  describe 'relationships' do
    it { should belong_to(:user) }
    it { should have_many(:applications_pets) }
    it { should have_many(:pets).through(:applications_pets) }
  end

  describe 'validations' do
    it { should validate_presence_of(:status) }
    it { should validate_presence_of(:user_id) }
    it { should validate_numericality_of(:user_id) }
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

    @association_2 = ApplicationsPet.create!(pet_id: @pet_2.id, status: "Pending", application_id: @application_2.id )
    @association_3 = ApplicationsPet.create!(pet_id: @pet_3.id, status: "Accepted", application_id: @application_3.id )
    @association_4 = ApplicationsPet.create!(pet_id: @pet_3.id, status: "Rejected", application_id: @application_3.id )

  end

  describe 'instance methods' do
    describe '.pets_empty' do
      it 'returns the true if there are no pets associated to an application' do
        expect(@application_1.pets_empty?).to eq(true)
        expect(@application_2.pets_empty?).to eq(false)
      end
    end

    describe '.user_name' do
      it 'returns the applicants name on the given application' do
        expect(@application_2.user_name).to eq(@user_2.full_name)
      end
    end
  end
end
