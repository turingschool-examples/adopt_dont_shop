require 'rails_helper'

RSpec.describe 'Approving/rejecting applications' do
  before :each do
    @app1 = Application.create!(fname: 'John', lname: 'Smithson', street_address: '12324 Turing Blvd.', city: 'Dtown', state: 'CO', zip_code: 12345, good_home_argument: 'Because reasons', status: "Pending" )
    @app2 = Application.create!(fname: 'John', lname: 'Smith', street_address: '1234 Turig Blvd.', city: 'Ttown', state: 'CO', zip_code: 12345, good_home_argument: 'Because reasonsable', status: "Pending" )

    @shelter1 = Shelter.create!(foster_program: true, name: 'Happy Shelter', city: 'Dmetro', rank: 3 )

    @pet1 = Pet.create!(adoptable: true, age: 5, breed: 'dog', name: 'Roofus', shelter_id: @shelter1.id)
    @pet2 = Pet.create!(adoptable: true, age: 12, breed: 'cat', name: 'Nacho', shelter_id: @shelter1.id)
    @pet3 = Pet.create!(adoptable: false, age: 8, breed: 'bird', name: 'Big', shelter_id: @shelter1.id)

    @shelter2 = Shelter.create!(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)

    @pet4 = Pet.create!(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: @shelter2.id)
    @pet5 = Pet.create!(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: @shelter2.id)

    @app1.pets << @pet1
    @app1.pets << @pet2
  end

  describe 'As an admin' do
    describe 'visit /admin/shelters' do
      it "has a section for 'Shelters with Pending Applications'" do
        visit '/admin/shelters'

        expect(page).to have_content('Shelters with Pending Applications')
      end

      it 'displays name of shelter(s) with pending applications' do
        visit '/admin/shelters'

        expect(page).to have_content("Happy Shelter")
        expect(page).to_not have_content("Aurora Shelter")
      end
    end
  end
end