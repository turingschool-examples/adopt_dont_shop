require 'rails_helper'

RSpec.describe Applicant, type: :model do 
  describe 'validations' do 
    it { should validate_presence_of :name}
    it { should validate_presence_of :street_address}
    it { should validate_presence_of :city}
    it { should validate_presence_of :state}
    it { should validate_presence_of :zip_code}
    # it { should validate_presence_of :description}
    it { should validate_presence_of :status}
  end
  describe 'relationship' do 
    it {should have_many(:pet_applicants)}
    it {should have_many(:pets).through(:pet_applicants)}
  end

  describe 'add pet' do 
    it 'will add searched pets to the applicant applying for them' do 
      shelter1 = Shelter.create!(name: "Oregon's Shady Shelter", city: "Portland", rank: 4, foster_program: true)
      pet1 = shelter1.pets.create!(name: "Taco", breed: "Dachshund", age: 4, adoptable: true)
      pet2 = shelter1.pets.create!(name: "Twiggy", breed: "Ant Eater", age: 6, adoptable: true)
      app3 = Applicant.create!(name: "Abdul Redd", street_address: "333 Ruby Rails Ct", city: "Miami", state: "FL", zip_code: "96352", description: "Tired of Students, want a pet that can learn properly")
      

      
      app3.add_pet(pet1.id)
      app3.add_pet(pet2.id)
      expect(app3.pets).to eq([pet1, pet2])
    end
  end
  
end