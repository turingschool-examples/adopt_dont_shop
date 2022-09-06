require 'rails_helper'
RSpec.describe Application, type: :model do
  describe 'relationships' do
    it { should have_many :pet_applications }

    it {should have_many(:pets).through(:pet_applications)}
  end

  describe 'class methods' do
    before  :each do
      @application1 = Application.new
      @application = Application.create!(name: "Shelby Waters", street_address: "274 West 11th St", city: "Myers Flatt", state: "NJ", zipcode: 12447, status: "In Progress", description: "I'm Lonely")
      @shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      @pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: @shelter_1.id)
      @pet_2 = Pet.create(adoptable: true, age: 348, breed: 'Wookie', name: 'Bark Hamill', shelter_id: @shelter_1.id)
    end

    it 'can search for pets with partial match' do
      expect(Application.search_pets('Ham')).to eq([@pet_2])
    end

    it 'can search for pets regardless of case' do
      expect(Application.search_pets('bArK hAmIlL')).to eq([@pet_2])
    end

    it 'can search for pets with a partial match, regardless of case' do
      expect(Application.search_pets('Il')).to eq([@pet_1, @pet_2])
    end
    #
    # it 'can approve a pet' do
    #   @application.approve(@pet_1)
    #   expect(@application.pet_application_approvals.count).to eq(1)
    # end
    #
    # it 'can reject a pet' do
    #   @application.reject(@pet_2)
    #   expect(@application.pet_application_rejects.count).to eq(1)
    # end

  end

end
