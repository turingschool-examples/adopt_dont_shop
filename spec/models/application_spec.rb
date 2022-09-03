require 'rails_helper'

RSpec.describe Application, type: :model do
  before :each do
    @shelter_1 = Shelter.create!(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    @shelter_2 = Shelter.create!(name: 'Humane Society', city: 'Humboldt CA', foster_program: true, rank: 4)
    
    @pet_1 = @shelter_1.pets.create!(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true)
    @pet_2 = @shelter_1.pets.create!(name: 'Fran', age: 4, breed: 'French Bulldog', adoptable: true)
    @pet_3 = @shelter_2.pets.create!(name: 'Gilbert', age: 4, breed: 'Mutt', adoptable: true)
    
    @app_1 = Application.create!(name: "Carter Ball", street_address: "123 Easy Street", city: "Atlanta", state: "GA", zip_code: 30307, description: "aaa")
    @app_2 = Application.create!(name: "Mary Ballantyne", street_address: "888 EZ Lane", city: "Denver", state: "CO", zip_code: 12345, description: "bbb")

  end
  
  describe "relationships" do
    # it { should have_many :application_pets}
    it {should have_many(:pets).through(:application_pets)}
  end

  describe "default attributes" do
    it 'defaults status to In Progress' do
      expect(@app_1.status).to eq("In Progress")
    end
  end

  it 'searches for a pet' do
    expect(@app_1.search_pet("fr")).to eq([@pet_2])
  end

end
