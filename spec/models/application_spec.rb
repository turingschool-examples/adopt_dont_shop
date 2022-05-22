require 'rails_helper'

RSpec.describe Application, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:street_address) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:zip) }
  end

  describe 'relatioinships' do
    it { should have_many(:application_pets) }
  end
  describe 'instance methods' do
    it 'shows status of application as In Progress' do
      application = Application.create!(name: "Bob Ross", street_address: "123 Trees St.", city: "Nantuket", state: "MA", zip: "12554")

      expect(application.status).to eq("In Progress")
    end
  end
end
