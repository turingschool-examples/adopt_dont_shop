require 'rails_helper'

RSpec.describe Application, type: :model do
  describe 'relationships' do
    it { should have_many :pet_applications }
    it { should have_many(:pets).through(:pet_applications) }
  end

  describe 'instance methods' do
    it 'can sort applications by pending status' do
      shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
      application_1 = Application.create!(name: "Britney Spears", address: "400 Hollywood Blvd", city: "Los Angeles", state: "CA", zipcode: 90027, description: "Richard is a good dog name", status: "Pending")
      application_2 = Application.create!(name: "Justin Timberlake", address: "100 Hollywood Blvd", city: "Los Angeles", state: "CA", zipcode: 90027, description: "I like dogs", status: "In Progress")

      expect(application_1.pending_app?).to be(true)
    end
  end

  # describe 'class methods' do
  #   it 'can display shelters with pending applications' do
  #     shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
  #     pet_3 = Pet.create!(name: "Richard", age: 5, breed: "Maine Coone", adoptable: true, shelter_id: shelter_1.id)
  #     application_1 = Application.create!(name: "Britney Spears", address: "100 Hollywood Blvd", city: "Los Angeles", state: "CA", zipcode: 90027, description: "I like dogs", status: "Pending")
  #     application_2 = Application.create!(name: "Justin Timberlake", address: "100 Hollywood Blvd", city: "Los Angeles", state: "CA", zipcode: 90027, description: "I like dogs", status: "Pending")
  #     PetApplication.create!(pet_id: pet_3.id, application_id: application_1.id)
  #
  #     expect(Application.display_pending_apps).to eq([application_1])
  #     # expect(Application.display_pending_apps).to_not eq([application_4, application_5])
  #   end
    # it 'can display shelters with pending applications' do
    #   # shelter_1 = Shelter.create(name: 'Aurora shelter', city: 'Aurora, CO', foster_program: false, rank: 9)
    #   # applications = Application.where(status: 1)
    #   # application_1 = Application.all.first
    #   # require "pry"; binding.pry
    #   application_1 = Application.create!(name: "Britney Spears", address: "100 Hollywood Blvd", city: "Los Angeles", state: "CA", zipcode: 90027, description: "I like dogs", status: "Pending")
    #   application_2 = Application.create!(name: "Justin Timberlake", address: "100 Hollywood Blvd", city: "Los Angeles", state: "CA", zipcode: 90027, description: "I like dogs", status: "Pending")
    #   application_3 = Application.create!(name: "Lil Kim", address: "100 Hollywood Blvd", city: "Los Angeles", state: "CA", zipcode: 90027, description: "I like dogs", status: "Pending")
    #   application_4 = Application.create!(name: "Snoop Dogg", address: "100 Hollywood Blvd", city: "Los Angeles", state: "CA", zipcode: 90027, description: "I like dogs", status: "In Progress")
    #   application_5 = Application.create!(name: "Eminem", address: "100 Hollywood Blvd", city: "Los Angeles", state: "CA", zipcode: 90027, description: "I like dogs", status: "In Progress")
    #   # pet_3 = Pet.create!(name: "Richard", age: 5, breed: "Maine Coone", adoptable: true, shelter_id: shelter_1.id)
    #   # PetApplication.create!(pet_id: pet_3.id, application_id: application_1.id)
    #   # require "pry"; binding.pry
    #   expect(Application.display_pending_apps).to eq([application_1, application_2, application_3])
    #   expect(Application.display_pending_apps).to_not eq([application_4, application_5])
    # end
  # end
end
