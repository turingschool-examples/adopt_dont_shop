require 'rails_helper'
RSpec.describe Application, type: :model do

  describe 'relationships' do
    it { should have_many :pet_applications }

    it {should have_many(:pets).through(:pet_applications)}
  end

  describe 'class methods' do
    before  :each do
      @application = Application.create!(name: "Shelby Waters", street_address: "274 West 11th St", city: "Myers Flatt", state: "NJ", zipcode: 12447, status: "In Progress", description: "I'm Lonely")
      @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      @pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: @shelter_1.id)
      @pet_2 = Pet.create(adoptable: true, age: 348, breed: 'Wookie', name: 'Bark Hamill', shelter_id: @shelter_1.id)
    end
    # describe 'search_pets_by_name' do
    #
    #   it 'can search for pets by name' do
    #     expect(Application.search_pets_by_name('Lucille Bald')).to eq([@pet_1])
    #
    #   end
    #
    # end

  end


end
