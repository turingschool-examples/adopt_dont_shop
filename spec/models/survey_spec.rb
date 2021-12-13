require 'rails_helper'

RSpec.describe Survey, type: :model do
  let(:shelter_1) {Shelter.create!(
    foster_program: true, 
    name: "Aspen Grove", 
    city: "Fort Collins", 
    rank: 1)}

  let(:survey_1) {Survey.create!(
    name: "John Napier", 
    street_address: "936 Akin Ave.", 
    city: "Fort Collins", 
    state: "CO.", 
    zip_code: 80521, 
    description: "Good Owner", 
    status: "Pending")}

  let!(:pet_1) {survey_1.pets.create!(
    adoptable: true, 
    age: 1, 
    breed: "Boston Terrier", 
    name: "Zelma", 
    shelter_id: shelter_1.id)}

  let!(:pet_2) {survey_1.pets.create!(
    adoptable: true, 
    age: 13, 
    breed: "Tabby Cat", 
    name: "Mazzy", 
    shelter_id: shelter_1.id)}

  let!(:pet_3) {Pet.create!(
    adoptable: true, 
    age: 14, 
    breed: "Chihuahua", 
    name: "Eleanor", 
    shelter_id: shelter_1.id)}

  describe 'validations' do 
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:street_address) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:zip_code) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:status) } 
  end

  describe 'relationships' do 
    it { should have_many(:survey_pets) }
    it { should have_many(:pets).through(:survey_pets) }
  end
end