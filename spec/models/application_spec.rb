require 'rails_helper'

RSpec.describe Application do
  describe 'relationships' do
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
    before :each do
      @shelter = Shelter.create!(foster_program: true, name: "GoodPets", city: "Denver", rank: 6000)
      @pet1 = @shelter.pets.create!(adoptable: true, age: 3, breed: "Shepard", name: "Alfonso")
      @pet2 = @shelter.pets.create!(adoptable: true, age: 6, breed: "Shepard", name: "Geoffrey")
      @pet3 = @shelter.pets.create!(adoptable: true, age: 7, breed: "Shepard", name: "Alfonso")
      @application = @pet1.applications.create!(name: "Billy Swanson", street_address: "543 Cherry St", city: "Denver", state: "CO", zip_code: "80033")
    end

    it '#pets_with_name finds all pets with given name' do
      expect(@application.pets_with_name('Alfonso')).to eq([@pet1, @pet3])
    end
  end
end
