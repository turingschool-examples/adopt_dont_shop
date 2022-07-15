require 'rails_helper'

RSpec.describe Application, type: :model do
  describe "validations" do
    it { should validate_presence_of :name }
    it { should validate_presence_of :street }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zipcode }
    it { should validate_presence_of :status }
    it { should validate_presence_of :description }
  end

  describe "relationships" do
    it {should have_many :pets}
  end

  describe "class methods" do
    describe "self.search" do 
      it 'will return a pet object when the pets name is entered' do 
        application = Application.create!(name: "Bob Bobbicus", street: "123 Main street", city: "Newtown", state: "State", zipcode: 80009, status:"In Progress", description:"I love dogs so much and have lots of food for them")
        shelter = Shelter.create!(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
        pet1 = Pet.create!(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)
      end
    end 
  end

   describe "instance methods" do
    
  end
end
