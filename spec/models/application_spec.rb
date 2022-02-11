require 'rails_helper'

RSpec.describe Application, type: :model do 

    before :each do 
        @application = Application.create!(name: "Aedan", street_address: "3425 Mansfield", city: "Denver", state: "CO", zipcode: "80236", description: "I love dogs")
    end
    describe 'validations' do
        it {should validate_presence_of :name}
        it {should validate_presence_of :street_address}
        it {should validate_presence_of :city}
        it {should validate_presence_of :state}
        it {should validate_presence_of :zipcode}
        it {should validate_presence_of :description}
    end 

    describe 'relationship' do 
        it {should have_many :pet_applications}
        it {should have_many(:pets).through(:pet_applications)}
    end
 
    it describe 'enum' do 
        application = Application.create!(name: "Aedan", street_address: "3425 Mansfield", city: "Denver", state: "CO", zipcode: "80236", description: "I love dogs")
        expect(Application.statuses).to eq({"In Progress"=>0, "Pending"=>1, "Accepted"=>2, "Rejected"=>3})
        expect(application.status).to eq("In Progress")
    end 
end 