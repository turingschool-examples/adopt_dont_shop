require 'rails_helper'

RSpec.describe 'Pet Edit' do
  before(:each) do
    @shelter = Shelter.create(name: 'Hollywood shelter', city: 'Irvine, CA', foster_program: false, rank: 7)
    @pet = Pet.create(adoptable: true, age: 3, breed: 'GSD', name: 'Charlie', shelter_id: @shelter.id)
  end
  describe 'When I visit /pets/edit/:id' do
    describe 'Then I see' do
      it "the veterinarian edit form" do
        visit "/pets/#{@pet.id}/edit"

        expect(find('form')).to have_content('Name')
        expect(find('form')).to have_content('Breed')
        expect(find('form')).to have_content('Adoptable')
        expect(find('form')).to have_content('Age')
      end

      context "given valid data" do
        it "submits the edit form and updates the veterinarian" do
          visit "/pets/#{@pet.id}/edit"

          fill_in 'Name', with: 'Itchy'
          uncheck 'Adoptable'
          fill_in 'Age', with: 1
          click_button 'Save'

          expect(page).to have_current_path("/pets/#{@pet.id}")
          expect(page).to have_content('Itchy')
          expect(page).to_not have_content('Charlie')
        end
      end

      context "given invalid data" do
        it 're-renders the edit form' do
          visit "/pets/#{@pet.id}/edit"

          fill_in 'Name', with: ''
          click_button 'Save'

          expect(page).to have_content("Error: Name can't be blank")
          expect(page).to have_current_path("/pets/#{@pet.id}/edit")
        end
      end
    end
  end
end
