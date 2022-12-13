require 'rails_helper'

RSpec.describe Application, type: :model do
  describe 'relationships' do
    it { should have_many :pet_applications }
    it { should have_many(:pets).through(:pet_applications) }
    it { should have_many(:shelters).through(:pets) }
  end

  describe 'instance methods' do
    before :each do
      @shelter = Shelter.create!(name: 'Snoops Dogs', city: 'Compton', rank: 1, foster_program: true)

      @james = @shelter.pets.create!(adoptable: true, age: 4, breed: 'King George Spaniel', name: 'James')
      @buster = @shelter.pets.create!(adoptable: true, age: 2, breed: 'Shnauzer - Wheaton mix', name: 'Buster')
      @marlowe = @shelter.pets.create!(adoptable: true, age: 9, breed: 'Pembroke Welsh Corgi', name: 'Marlowe')

      @app1 = Application.create!(
        name: 'Frank Sinatra',
        street_address: '69 Sinatra Way',
        city: 'Nashville',
        state: 'Tennessee', zip_code: '69420', description: "I've always liked dogs",
        status: 'Pending'
      )
    end
    describe '#find_pa_status' do
      it 'should return the status of a pet application based on its pet_id and application_id' do
        PetApplication.create!(pet: @james, application: @app1)
        PetApplication.create!(pet: @buster, application: @app1, status: 'true')
        PetApplication.create!(pet: @marlowe, application: @app1, status: 'false')

        expect(@app1.find_pa_status(@james.id)).to eq(nil)
        expect(@app1.find_pa_status(@buster.id)).to eq('true')
        expect(@app1.find_pa_status(@marlowe.id)).to eq('false')
      end
    end

    describe '#status_message' do
      it 'returns a string based on the status of a row in pet_applications' do
        PetApplication.create!(pet: @buster, application: @app1, status: 'true')
        PetApplication.create!(pet: @marlowe, application: @app1, status: 'false')

        expect(@app1.status_message(@buster.id)).to eq('Application Approved!')
        expect(@app1.status_message(@marlowe.id)).to eq('Application Rejected')
      end
    end
  end
end
