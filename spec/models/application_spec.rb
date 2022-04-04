require 'rails_helper'

RSpec.describe Application, type: :model do

  describe 'validation' do
    it {should validate_presence_of :name}
    it {should validate_presence_of :street_address}
    it {should validate_presence_of :city}
    it {should validate_presence_of :state}
    it {should validate_presence_of :zipcode}
    it {should validate_presence_of :status}
  end

  describe 'relationships' do
    it {should have_many(:pets).through(:pet_applications)}
  end

  describe 'class methods' do
    
  end

  describe 'instance methods' do

  end
end
