require 'rails_helper'

RSpec.describe PetApplication, type: :model do
  describe 'relationships' do
    it { should belong_to(:pet) }
    it { should belong_to(:application) }
  end

  describe 'validations' do
    it { should validate_presence_of(:pet_id) }
    it { should validate_presence_of(:application_id) }
  end

  before(:each) do
    @shelter_1 = Shelter.create!(foster_program: true, name: "Idaho Humane Society", city: "Boise", rank: 3)
    @shelter_2 = Shelter.create!(foster_program: true, name: "Denver Humane Society", city: "Denver", rank: 1)

    @pet_1 = @shelter_1.pets.create!(adoptable: true, age: 2, breed: "Mastiff", name: "Sir Willim Wallace")
    @pet_2 = @shelter_1.pets.create!(adoptable: false, age: 1, breed: "German Short Hair", name: "Blazer")
    @pet_3 = @shelter_1.pets.create!(adoptable: false, age: 2, breed: "Newfoundland", name: "Dean")
    @pet_4 = @shelter_2.pets.create!(adoptable: false, age: 4, breed: "Mix Breed", name: "Wanda")
    @pet_5 = @shelter_2.pets.create!(adoptable: true, age: 3, breed: "Mane Coon", name: "Tina")

    @application_1 = Application.create!(name: "George", state: "Idaho", city: "Boise", zip_code: 83616, address: "395 Middle Street", description: "student", status: "Accepted")
    @application_1 = Application.create!(name: "Fred", state: "Idaho", city: "Star", zip_code: 83616, address: "395 State Street", description: "student", status: "Accepted")
    @application_1 = Application.create!(name: "Ronald", state: "Idaho", city: "Boise", zip_code: 83616, address: "395 Start Road", description: "Teacher", status: "In Progress")
    @application_1 = Application.create!(name: "Ginny", state: "Idaho", city: "Eagle", zip_code: 83616, address: "395 Home Way", description: "Land Owner", status: "Accepted")
    @application_1 = Application.create!(name: "Percy", state: "Colorado", city: "Meridian", zip_code: 83616, address: "395 Artesian Street", description: "Government Official", status: "Rejected")
    @application_1 = Application.create!(name: "Charlie", state: "Colorado", city: "Nampa", zip_code: 83616, address: "395 Eagle Road", description: "Anthropologist", status: "Pending")
    @application_1 = Application.create!(name: "Bill", state: "Colorado", city: "Kuna", zip_code: 83616, address: "395 Purple Street", description: "student", status: "Accepted")
  end
end