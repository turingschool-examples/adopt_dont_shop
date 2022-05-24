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
      application1 = Application.create!(name: "Bob Ross", street_address: "123 Trees St.", city: "Nantuket", state: "MA", zip: "12554", status: true)
      application2 = Application.create!(name: "Bob Ross", street_address: "123 Trees St.", city: "Nantuket", state: "MA", zip: "12554", status: false)

      expect(application1.status_display).to eq("In Progress")
      expect(application2.status_display).to eq("Pending")
    end
  end
end
