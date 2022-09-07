require 'rails_helper'

RSpec.describe 'admin show page' do
  before :each do
    @fontaine = Shelter.create!(name: 'Fontainebleu Institute of Varmint Husbandry', city: 'Golden, CO', foster_program: true, rank: 6)
    @trash = @fontaine.pets.create!(adoptable: true, name: "King Trash Mouth", age: 14, breed: "Torch Key")
    @princess = @fontaine.pets.create!(adoptable: true, name: "Princess Dumptruck", age: 18, breed: "Cozumel")
    @eggs = @fontaine.pets.create!(adoptable: true, name: "Eggs Sinclair", age: 10, breed: "Tres Marias")
    @wendy = @fontaine.pets.create!(adoptable: true, name: "Monster Truck Wendy", age: 5, breed: "Vancouver Island")
    @grom = @fontaine.pets.create!(adoptable: true, name: "Grom the Paunch", age: 6, breed: "Cacomistle")
    @ken = @fontaine.pets.create!(adoptable: true, name: "Big Paws Ken", age: 5, breed: "Western Lowland Olingo")
    visit "/admin/shelters/#{@fontaine.id}"
  end

  it 'displays the shelter full name and address' do
    expect(page).to have_content(@fontaine.name)
    expect(page).to have_content(@fontaine.city)
  end

  describe 'statistics section' do
    it 'displays the average age of pets at shelter' do
      expect(@fontaine.average_pet_age).to eq(9.67)
      within("#stats") do
        expect(page).to have_content(@fontaine.average_pet_age)
      end
    end

    it 'displays the number of adoptable pets at the shelter' do
      fontaine = Shelter.create!(name: 'Fontainebleu Institute of Varmint Husbandry', city: 'Golden, CO', foster_program: true, rank: 6)
      trash = fontaine.pets.create!(adoptable: true, name: "King Trash Mouth", age: 14, breed: "Torch Key")
      princess = fontaine.pets.create!(adoptable: true, name: "Princess Dumptruck", age: 18, breed: "Cozumel")
      eggs = fontaine.pets.create!(adoptable: false, name: "Eggs Sinclair", age: 10, breed: "Tres Marias")
      wendy = fontaine.pets.create!(adoptable: false, name: "Monster Truck Wendy", age: 5, breed: "Vancouver Island")

      visit "/admin/shelters/#{fontaine.id}"

      expect(fontaine.num_adoptable_pets).to eq(2)
      expect(fontaine.num_pets_adopted).to eq(2)

      within("#stats") do
        expect(page).to have_content("Adoptable pets: 2")
        expect(page).to have_content("Pets already adopted: 2")
      end
    end
  end
end