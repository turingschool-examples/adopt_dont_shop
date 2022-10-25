require 'rails_helper'

RSpec.describe 'Pet Show' do
  before(:each) do
    @shelter = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    @pet = Pet.create(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: @shelter.id)
  end
  describe 'When I visit /pets/:id' do
    describe 'Then I see' do
      it "the shelter and all it's attributes" do
        visit "/pets/#{@pet.id}"

        expect(page).to have_content(@pet.name)
        expect(page).to have_content(@pet.age)
        expect(page).to have_content(@pet.adoptable)
        expect(page).to have_content(@pet.breed)
        expect(page).to have_content(@pet.shelter_name)
      end

      it 'a button to delete a pet' do
        visit "/pets/#{@pet.id}"

        expect(page).to have_link("Delete #{@pet.name}")
      end
    end

    describe 'When I click on "Delete PET"' do
      it "the pet is removed from the page" do
        visit "/pets/#{@pet.id}"

        click_on("Delete #{@pet.name}")

        expect(page).to have_current_path('/pets')
        expect(page).to_not have_content(@pet.name)
      end
    end
  end
end
