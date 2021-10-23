require "rails_helper"

RSpec.describe Application, type: :model do
  describe "relationships" do
    it { should have_many :application_pets}
    it { should have_many(:pets).through(:application_pets)}
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:street_address) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:zip) }
  end

  describe "attributes" do
    it 'has name, full address, description, and status' do
      application = Application.create!(
                                        name: "Nate Brown",
                              street_address: "2000 35th Avenue",
                                        city: "Denver",
                                       state: "CO",
                                         zip: "90210",
                                 description: "I have a big backyard",
                                      status: "In Progress"
                                        )

      expect(application.name).to eq("Nate Brown")
      expect(application.full_address).to eq("2000 35th Avenue, Denver, CO, 90210")
      expect(application.description).to eq("I have a big backyard")
      expect(application.status).to eq("In Progress")
    end
  end
end
