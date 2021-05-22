# frozen_string_literal: true

require 'rails_helper'

RSpec.describe VeterinaryOffice, type: :model do
  describe 'relationships' do
    it { should have_many(:veterinarians) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:max_patient_capacity) }
    it { should validate_numericality_of(:max_patient_capacity) }
  end

  before(:each) do
    @vet_office_1 = VeterinaryOffice.create(name: 'Best Vets', boarding_services: true, max_patient_capacity: 20)
    @vet_office_2 = VeterinaryOffice.create(name: 'Vets R Us', boarding_services: true, max_patient_capacity: 20)
    @not_on_call_vet = Veterinarian.create(name: 'Sam', review_rating: 10, on_call: false,
                                           veterinary_office_id: @vet_office_1.id)
    @vet_1 = Veterinarian.create(name: 'Taylor', review_rating: 10, on_call: true,
                                 veterinary_office_id: @vet_office_1.id)
    @vet_2 = Veterinarian.create(name: 'Jim', review_rating: 8, on_call: true, veterinary_office_id: @vet_office_1.id)
    @vet_3 = Veterinarian.create(name: 'Sarah', review_rating: 9, on_call: true, veterinary_office_id: @vet_office_2.id)
  end

  describe 'class methods' do
    describe '#search' do
      it 'returns partial matches' do
        expect(VeterinaryOffice.search('Vets')).to eq([
                                                        @vet_office_1, @vet_office_2
                                                      ])
      end
    end

    describe '#order_by_recently_created' do
      it 'orders the offices by those most recently created first' do
        expect(VeterinaryOffice.order_by_recently_created).to eq([
                                                                   @vet_office_2, @vet_office_1
                                                                 ])
      end
    end

    describe '#order_by_number_of_vets' do
      it 'orders the offices by those with most veterinarians to least' do
        expect(VeterinaryOffice.order_by_number_of_vets).to eq([
                                                                 @vet_office_1, @vet_office_2
                                                               ])
      end
    end
  end

  describe 'instance methods' do
    describe '.vet_count' do
      it 'returns the number of veterinarians associated with the given office' do
        expect(@vet_office_1.vet_count).to eq(3)
        expect(@vet_office_2.vet_count).to eq(1)
      end
    end

    describe '.alphabetical_vets' do
      it 'returns the office veterinarians alphabetically by name' do
        expect(@vet_office_1.alphabetical_vets).to eq([@vet_2, @vet_1])
      end
    end

    describe '.on_call_vets' do
      it 'only returns office veterinarians who are on call' do
        expect(@vet_office_1.on_call_vets).to eq([@vet_1, @vet_2])
      end
    end

    describe '.office_vets_filtered_by_rating' do
      it 'filters the office vets based on given rating' do
        expect(@vet_office_1.office_vets_filtered_by_rating(9)).to eq([@vet_1])
      end
    end
  end
end
