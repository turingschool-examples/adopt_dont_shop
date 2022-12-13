require 'rails_helper'

RSpec.describe ApplicationPet, type: :model do
  describe 'relationships' do
    it { should belong_to(:pet) }
    it { should belong_to(:application) }
  end

  it 'can find an application pet when given application and pet ids' do
    @shelter = Shelter.create({ name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9 })

    @application = Application.create({
                                        name: 'Jeff',
                                        street_address: '123 Main Street',
                                        city: 'Denver',
                                        state: 'CO',
                                        zip_code: 22_314,
                                        reason: 'Nice person'
                                      })

    @pet_1 = @application.pets.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald',
                                      shelter_id: @shelter.id)
    @pet_2 = @application.pets.create(adoptable: true, age: 5, breed: 'lab', name: 'Dogmin', shelter_id: @shelter.id)

    expect(ApplicationPet.find_application_pet(@application.id, @pet_1.id).pet_id).to eq(@pet_1.id)
    expect(ApplicationPet.find_application_pet(@application.id, @pet_1.id).application_id).to eq(@application.id)
  end
end
