require 'rails_helper'

RSpec.describe PetApplication, type: :model do
  describe 'relationships' do
    it { should belong_to(:application) }
    it { should belong_to(:pet) }
  end

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

    @pet_app1 = PetApplication.create(pet_id: @pet1.id, application_id: @app1.id,  pet_status: "Adoption Rejected")
    @pet_app2 = PetApplication.create(pet_id: @pet2.id, application_id: @app1.id,  pet_status: "Adoption Approved")
    @pet_app3 = PetApplication.create(pet_id: @pet1.id, application_id: @app2.id)
  end

  describe 'class tests' do
    describe '.pet_count' do
      it 'counts pets on an application' do
        expect(described_class.pet_count(@app1)).to eq(2)
      end
    end

    describe '.pets_app_rej_count' do
      it 'counts pets on rejected app' do
        expect(described_class.pets_app_rej_count(@app1)).to eq(2)
      end
    end

    describe '.pets_rej_count(app_id)' do
      it 'counts rejected pets' do
        expect(described_class.pets_rej_count(@app1)).to eq(1)
      end
    end

    describe '#application_complete?' do
      it 'provides a boolean of whether all pets on an application have been approved/rejected' do
        expect(@pet_app1.application_complete?(@app1.id)).to eq(true)
        expect(@pet_app2.application_complete?(@app2.id)).to eq(false)
      end
    end

    describe '#complete_application' do
      it 'updates status of application to rejected/accepted' do
        @pet_app1.complete_application(@app1)
        expect(@app1.status).to eq("Rejected")
        @pet_app3.update(pet_status: "Adoption Approved")
        @pet_app3.complete_application(@app2)

        expect(@app2.status).to eq("Accepted")
      end

      it 'updates all pets to not adoptable if application status is accepted' do
        expect(@pet1.adoptable).to eq(true)
        @pet_app3.update(pet_status: "Adoption Approved")
        @pet_app3.complete_application(@app2)

        expect(@app2.pets.first.adoptable).to eq(false)
      end
    end
  end
end