require 'rails_helper'

RSpec.describe Application, type: :model do
  describe 'relationships' do
    it { should have_many(:application_pets) }
    it { should have_many(:pets).through(:application_pets) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:street_address) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_numericality_of(:zip_code) }
    it { should validate_length_of(:zip_code).is_equal_to(5) }
  end

  describe 'the pets in which an applicant is applying' do
    it 'returns all pets the applicant has applied for' do
      shelter = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)

      mike = Application.create!(
                name: 'Mike Dao',
                street_address: '245 Maple St',
                city: 'Centennial',
                state: 'Colorado',
                zip_code: '80112',
                applicant_bio: 'My dog needs another to chase up trees.',
                application_status: 'Pending')


      chris = Application.create!(
                name: 'Chris Simmons',
                street_address: '533 Oak St',
                city: 'Columbus',
                state: 'Ohio',
                zip_code: '43004',
                applicant_bio: 'Because how much more work could a third cat be?',
                application_status: 'In Progress')

      dani = Application.create!(
                name: 'Dani Coleman',
                street_address: '912 Willow St',
                city: 'Arvada',
                state: 'Colorado',
                zip_code: '80003',
                applicant_bio: 'Because I am just awesome.',
                application_status: 'Accepted')

      charlie = mike.pets.create!(adoptable: true, age: 3, breed: 'GSD', name: 'Charlie', shelter_id: shelter.id)
      mina = dani.pets.create!(adoptable: true, age: 1, breed: 'ND', name: 'Mina', shelter_id: shelter.id)
      chloe = chris.pets.create!(adoptable: true, age: 2, breed: 'Tabby', name: 'Chloe', shelter_id: shelter.id)
      vida = dani.pets.create!(adoptable: true, age: 4, breed: 'Yorkshire', name: 'Vida', shelter_id: shelter.id)

      expect(mike.applicant_pets).to eq([charlie])
      expect(dani.applicant_pets).to eq([mina, vida])
      expect(chris.applicant_pets).to eq([chloe])
    end
  end

end
