require 'rails_helper'

RSpec.describe PetApplication, type: :model do
  describe 'relationships' do
    it { should belong_to(:pet) }
    it { should belong_to(:application) }
  end

  before(:each) do
    @shelter1 = Shelter.create!(foster_program: true, name: "Moms and Mutts", city: "Denver", rank:1)
    @application = Application.create!(name:"Becka Hendricks", street_address:"6210 Castlegate Dr.", city:"Castle Rock", state:"Colorado", zipcode:"80108", status: "In Progress", description: "NO DESC[N/A]")
    @pet1 = @shelter1.pets.create!(adoptable: true, age:3, breed:"Pitbull", name:"Scrappy")
    @pet2 = @shelter1.pets.create!(adoptable: true, age:5, breed:"German Shepherd", name:"Gossamer")
  end

  describe 'class methods' do
    describe '#associate' do
      it 'associates the given application to a pet' do
        pet_name = @pet1.id

        expect(PetApplication.associate(pet_name, @application)).to be_instance_of PetApplication
      end
    end
  end
end
