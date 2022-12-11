require 'rails_helper'

RSpec.describe Application, type: :model do
  describe 'relationships' do
    it { should have_many(:pet_applications) }
    it { should have_many(:pets).through(:pet_applications) }
  end

  describe 'application methods and attributes' do
    before :each do
      @application = create(:application)
      @shelter_1   = create(:shelter)
      @pet_1       = create(:pet, shelter: @shelter_1)
      @pet_2       = create(:pet, shelter: @shelter_1)
      @pet_3       = create(:pet, shelter: @shelter_1)
    end

    describe '#add_pet' do
      it 'adds a pet to the application and application_pet tables' do
        
        expect(@application.pets.empty?).to be true

        @application.add_pet(@pet_1.id)

        expect(@application.pets.empty?).to be false
        expect(@application.pets.count).to be(1)
        expect(@application.pets[0].name).to eq(@pet_1.name)
      end
    end
  end
end