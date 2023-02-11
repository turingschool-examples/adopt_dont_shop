require 'rails_helper'

RSpec.describe Application do 
  before(:each) do 
    applicant_1 = Application.create!(name: "Joe", street_address: "123 House", city: "Denver", state: "CO", zipcode: 80220, description: "Dog dad", status: "In Progress")
  end
  describe 'it exists' do 
    it {should validate_presence_of :name } 
    it {should validate_presence_of :street_address } 
    it {should validate_presence_of :city } 
    it {should validate_presence_of :state } 
    it {should validate_presence_of :zipcode } 
    it {should validate_presence_of :description } 
  end
end