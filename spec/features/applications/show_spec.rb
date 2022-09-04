require 'rails_helper'

RSpec.describe 'the applications show' do
  describe 'As a visitor' do
    before :each do
      @shelter1 = Shelter.create!(foster_program: true, name: "Moms and Mutts", city: "Denver", rank:1)
      @application1 = Application.create!(name:"Becka Hendricks", street_address:"6210 Castlegate Dr.", city:"Castle Rock", state:"Colorado", zipcode:"80108", description:"I love dogs and would be such a good dog mom", status: "In Progress")
      @pet1 = @shelter1.pets.create!(adoptable: true, age:3, breed:"Pitbull", name:"Scrappy")
      @pet2 = @shelter1.pets.create!(adoptable: true, age:5, breed:"German Shepherd", name:"Gossamer")
      PetApplication.create!(pet: @pet1, application: @application1)
      PetApplication.create!(pet: @pet2, application: @application1)
    end

    describe 'when I visit an applications show page' do
      it 'I can see the name of the applicant' do
        visit '/applications'

        expect(page).to have_content(@application1.name)
      end

      it 'I can see the full address of the applicant including street address, city, state, and zip code' do
        visit '/applications'

        expect(page).to have_content(@application1.street_address)
        expect(page).to have_content(@application1.city)
        expect(page).to have_content(@application1.state)
        expect(page).to have_content(@application1.zipcode)
      end

      it 'I can see a description of why the applicant says theyd be a good home for this pet(s)' do
        visit '/applications'

        expect(page).to have_content(@application1.description)
      end

      it 'I can see the names of all pets that this application is for (all names of pets should be links to their show page)' do
        visit '/applications'

        expect(page).to have_content(@pet1.name)
        expect(page).to have_content(@pet2.name)
      end

      it 'I can see the Applications status, either "In Progress", "Pending", "Accepted", or "Rejected"' do
        visit '/applications'

        expect(page).to have_content(@application1.status)
      end
    end
  end
end
