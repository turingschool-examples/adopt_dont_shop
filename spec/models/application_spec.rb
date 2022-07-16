require 'rails_helper'

RSpec.describe Application, type: :model do
  describe 'relationships' do
    it { should have_many :application_pets }
    it { should have_many(:pets).through(:application_pets) }
  end

  describe 'validations' do 
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:street_address) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:zip_code) }
  end

  # describe 'instance methods' do 
  #   it 'checks that the required fields have been entered' do 
  #     params = Hash.new 
  #     params[:street_address] = '1234 Ever Lane'
  #     params[:city] = 'Jersey City'
  #     params[:state] = nil
  #     params[:zip] = '12345'

  #     expect(params.check_fields?).to eq false 
  #   end
  # end
end
