require 'rails_helper'

RSpec.describe Application do
  it {should have_many(:pets).through(:application_pets)}
  it { should have_many :application_pets}
  describe 'Change status' do
    it 'changes the status to pending' do
      application = Application.create!(name: 'Billy Bob', street_address: "54984 Bulldog Rd", city: "Salem", state: "OR", zipcode: "97301")
     
      application.change_status

      expect(application.status).to eq('Pending')
    end
  end
end