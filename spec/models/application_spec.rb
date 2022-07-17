require 'rails_helper'

RSpec.describe Application, type: :model do
  describe 'relationships' do
    it { should have_many :application_pets }
    it { should have_many(:pets).through(:application_pets) }
  end

  describe 'validations' do 
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:street_address) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:zip_code) }
  end

  describe 'instance methods' do 
    it 'updates the ApplicationPets status when the Application status changes to Pending' do 
      app = Application.create!(name: 'Brigitte Bardot', street_address: '123 Main Street', city: 'Denver', state: 'CO', zip_code: '80111', status: 1)

      shelter_1 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      shelter_2 = Shelter.create!(name: 'RGV animal shelter', city: 'Harlingen, TX', foster_program: false, rank: 5)
      shelter_3 = Shelter.create!(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
      pirate = shelter_1.pets.create!(name: 'Mr. Pirate', breed: 'tuxedo shorthair', age: 5, adoptable: true)
      clawdia = shelter_1.pets.create!(name: 'Clawdia', breed: 'shorthair', age: 3, adoptable: true)
      lucy = shelter_3.pets.create!(name: 'Lucille Bald', breed: 'sphynx', age: 8, adoptable: true)
      app_pirate = ApplicationPet.create!(application: app, pet: pirate)
      app_lucy = ApplicationPet.create!(application: app, pet: lucy)

      app.update_ap_status

      expect(app_pirate.reload.status).to eq('Pending')
      expect(app_lucy.reload.status).to eq('Pending')
    end
  end
end
