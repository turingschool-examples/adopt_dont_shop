require "rails_helper"

RSpec.describe Application, type: :model do
  describe "relationships" do
    it {should have_many :application_pets}
    it {should have_many(:pets).through(:application_pets)}
  end

  describe 'instance methods' do
    it 'should be able to determine in progress or not' do
      app_1 = Application.create(name: 'Jonah Hill', street_address: '65 High St', city: 'New York', state: 'NY', zip: 28938, description: 'Animals love me!', status: 'In Progress')

      expect(app_1.in_progress?).to be true
    end

  end
end