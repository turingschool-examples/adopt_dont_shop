require "rails_helper"

RSpec.describe Application, type: :model do
  describe "validations" do
    it { should validate_presence_of :name}
    it { should validate_presence_of :street_address}
    it { should validate_presence_of :city}
    it { should validate_presence_of :state}
    it { should validate_presence_of :zip_code}
  end

  describe "relationships" do
    it { should have_many :application_pets }
    it { should have_many(:pets).through(:application_pets) }
  end


  # Add a Pet to an Application
  #
  # As a visitor
  # When I visit an application's show page
  # And I search for a Pet by name
  # And I see the names Pets that match my search
  # Then next to each Pet's name I see a button to "Adopt this Pet"
  # When I click one of these buttons
  # Then I am taken back to the application show page
  # And I see the Pet I want to adopt listed on this application
  describe "im" do
    xit 'can add pet to application' do
      application_1 = Application.create!(name: "Jose Molina", street_address: "123 Federal", city: "Denver", state: "CO", zip_code: "80203", description: "I want to give an animal a happy home")
      application_2 = Application.create!(name: "Ana Lopez", street_address: "3333 Colfax", city: "Denver", state: "CO", zip_code: "80204", description: "I am good animals ")
      shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      pet_1 = @application_1.pets.create!(name: 'Simba', age:12, breed: 'Doberman', adoptable: true, shelter: shelter_1)
      pet_2 = @application_2.pets.create!(name: 'Jack', age:2, breed: 'Mutt', adoptable: true, shelter: shelter_1)
      pet_3 = @application_2.pets.create!(name: 'Terry', age:6, breed: 'Lab', adoptable: true, shelter: shelter_1)
      firulais = Pet.create!(name: 'Firulais', age:1, breed: 'Lab', adoptable: true, shelter: shelter_1)

      expect(application_1.pets).to eq([])
      application_1.adopt(firulais)
      expect(application_1.pets).to eq([firulais])
    end
  end
end
