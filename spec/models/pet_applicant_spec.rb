require 'rails_helper'

RSpec.describe PetApplicant do
  describe 'relationships' do
    it {should belong_to :pet}
    it {should belong_to :applicant}
  end

  before(:each) do
    @furry = Shelter.create!(name:'Furrry Shelter', foster_program: true, city: 'New Orleans', rank: 5)

    @bruce = @furry.pets.create!(name: 'Bruce', age: 3, adoptable: true, breed: 'black lab')
    @lana = @furry.pets.create!(name: 'Lana', age: 1, adoptable: true, breed: 'short-haired')
    @doc = @furry.pets.create!(name: 'Doc', age: 8, adoptable: true, breed: 'schnauzer')
    @doctor = @furry.pets.create!(name: 'Doctor', age: 9, adoptable: true, breed: 'pomeranian')

    @application1 = Applicant.create!(name: 'Carina', street_address: '455 Cool Street', city: 'Portland', state: 'OR', zip_code: 23392, status: 'In Progress')

    @application2 = Applicant.create!(name: 'Evan', street_address: '1234 Sparky Lane', city: 'Portland', state: 'OR', zip_code: 23392, home_description: 'I like playing and throwing ball with dogs', status: 'In Progress')

    @application1.pets << [@lana, @doc]
  end
  describe 'class methods' do
    it 'can find pet and application instance' do
      expect(PetApplicant.find_by_parents(@lana.id, @application1.id).pet_id).to eq(@lana.id)
    end
  end
end
