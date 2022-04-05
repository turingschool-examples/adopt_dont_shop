require 'rails_helper'

RSpec.describe Application, type: :model do
  before do
    @shelter = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @pet_1 = @shelter.pets.create(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true,
                                  shelter_id: @shelter.id)
    @pet_2 = @shelter.pets.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster',
                                  shelter_id: @shelter.id)
    @pet3 = @shelter.pets.create!(adoptable: true, age: 7, breed: 'Golden Retriever', name: 'Carter')
    @application1 = Application.create!(name: 'Chris', address: '123 Main St', city: 'Hometown', state: 'CO',
                                        zipcode: '80504')
  end

  describe 'relationships' do
    it { should have_many(:pets).through(:pet_applications) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:address) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:zipcode) }
    it { should validate_presence_of(:status) }
  end

  describe 'methods' do
    it 'updates status if description and pets are present' do
      expect(@application1.status).to eq('In Progress')
      @application1.update_status_pending
      expect(@application1.status).to eq('Pending')
    end
  end
end
