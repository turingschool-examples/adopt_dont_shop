require 'rails_helper'

RSpec.describe Petition do
  describe 'relationships' do
    it {should have_many(:pet_petitions) }
    it { should have_many(:pets).through(:pet_petitions)}
  end

  describe 'validations' do
    it 'should validate every element' do
      ted = Petition.new(name: 'Ted Leo', 
                         street_address: '123 Pharmacist Ln', 
                         city: 'Phoenix City',
                         state: 'Alabama',
                         zipcode: '12345')

      noname = Petition.new(street_address: '123 Pharmacist Ln', 
                            city: 'Phoenix City',
                            state: 'Alabama',
                            zipcode: '12345')
      nostreet = Petition.new(name: 'Ted Leo',
                              city: 'Phoenix City',
                              state: 'Alabama',
                              zipcode: '12345')
      nocity = Petition.new(name: 'Ted Leo', 
                            street_address: '123 Pharmacist Ln', 
                            state: 'Alabama',
                            zipcode: '12345')
      nostate = Petition.new(name: 'Ted Leo', 
                             street_address: '123 Pharmacist Ln', 
                             city: 'Phoenix City',
                             zipcode: '12345')
      nozip = Petition.new(name: 'Ted Leo', 
                           street_address: '123 Pharmacist Ln', 
                           city: 'Phoenix City',
                           state: 'Alabama')

      expect(ted.save).to eq true
      expect(noname.save).to eq false
      expect(nostreet.save).to eq false
      expect(nocity.save).to eq false
      expect(nostate.save).to eq false
      expect(nozip.save).to eq false
    end
  end
end