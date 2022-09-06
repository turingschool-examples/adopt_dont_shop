require 'rails_helper'

RSpec.describe ApplicantPet, type: :model do
  describe 'relationships' do
    it { should belong_to :pet }
    it { should belong_to :applicant }
  end

  describe 'class methods' do
    before :each do
    @shelter = Shelter.create!(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    @applicant = Applicant.create!(first_name: 'John', last_name: 'Dough', street_address: '123 Fake Street', city: 'Denver', state: 'CO', zip: 80205, description: "I'm awesome", status: 'Pending')
    @pet_1 = @applicant.pets.create!(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: @shelter.id)
    @pet_2 = @applicant.pets.create!(name: 'Jake', age: 5, breed: 'Pug', adoptable: true, shelter_id: @shelter.id)
    # require "pry"; binding.pry
    ApplicantPet.where(applicant_id: @applicant.id).where(pet_id: @pet_1.id).update(approved: true)
    # ApplicantPet.where(applicant_id: (@applicant.id)).where({pet_id: (@pet_2.id)}).update(approved: true)
    end

    it "#self.approved?" do
      # require "pry"; binding.pry
      expect(ApplicantPet.approved?(@applicant.id, @pet_1.id)).to eq true
    end

    it "#self.app_status" do
    expect(ApplicantPet.app_status(@applicant.id, @pet_1.id)).to be_truthy
    end
  end
end