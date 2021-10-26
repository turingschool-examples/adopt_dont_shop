require 'rails_helper'

RSpec.describe ApplicationPet, type: :model do
  describe "relationships" do
    it { should belong_to :application }
    it { should belong_to :pet }
  end
  before(:each) do
    @shelter_1 = Shelter.create(name: 'Edgewater shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    @application_1 = Application.create!(
                                      name: "Nate Brown the 3rd",
                            street_address: "2000 35th Avenue",
                                      city: "Denver",
                                     state: "CO",
                                       zip: "90210",
                               description: "Big ass backyard",
                                    status: "Pending"
                                           )
    @pet_1 = Pet.create!(name: 'Jonathan Whiskers', breed: 'tuxedo shorthair', age: 5, adoptable: true, shelter: @shelter_1)
    @pet_2 = Pet.create!(name: 'Jack Handy', breed: 'shorthair', age: 3, adoptable: true, shelter: @shelter_1)

    @application_pet_1 = ApplicationPet.create!(application: @application_1, pet: @pet_1)
    @application_pet_2 = ApplicationPet.create!(application: @application_1, pet: @pet_2)
  end
  describe "#approve" do
    it "changes state to Approved" do
      @application_pet_1.approve

      expect(@application_pet_1.state).to eq('Approved')
    end
  end

  describe "#reject" do
    it "changes state to Rejected" do
      @application_pet_2.reject

      expect(@application_pet_2.state).to eq('Rejected')
    end
  end
end
