require 'rails_helper'

RSpec.describe Application, type: :model do
  describe 'relationships' do
    it {should have_many :application_pets}
    it {should have_many(:pets).through(:application_pets)}
  end

  describe "Instance methods" do
    describe '#incomplete_form?' do
      it 'checks for incomplete form fields' do
        application = Application.create!(name: "Bob Smith", street_address: "1234 Easy St.", state: "CO", zipcode: 80001, description: 'temp description', status: "In Progress")

        expect(application.incomplete_form?).to be true
      end
    end
    describe '#list_incomplete_fields' do
      it "returns and array of incomplete fields" do
        application = Application.create!(name: "Bob Smith", street_address: "1234 Easy St.", zipcode: 80001, description: 'temp description', status: "In Progress")

        expect(application.list_incomplete_fields).to eq(["city", "state"])
      end
    end
  end
  describe "Class methods" do
  end
end
