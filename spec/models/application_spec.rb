require 'rails_helper'

RSpec.describe Application do
  describe 'relationships' do
    it {should have_many(:pet_applications)}
    it {should have_many(:pets).through(:pet_applications)}
  end

  describe 'validations' do
    it { should validate_presence_of(:name)}
    it { should validate_presence_of(:street_address)}
    it { should validate_presence_of(:city)}
    it { should validate_presence_of(:state)}
    it { should validate_presence_of(:zipcode)}
    # it { should validate_presence_of(:description)}
    # it { should validate_presence_of(:status)}
  end

  it 'sets default settings for specific fields' do
    application_1 = Application.create!(name: 'Anita Barker', street_address: '2468 Park Blvd.', city: 'Denver', state: 'CO', zipcode: '80202')

    expect(application_1.description).to eq("")
    expect(application_1.status).to eq("In Progress")
  end
end
