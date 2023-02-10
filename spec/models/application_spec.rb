require 'rails_helper'

RSpec.describe Application, type: :model  do
  describe 'relationships' do
    it { should have_many(:application_pets) }
    it { should have_many(:pets).through(:application_pets) }
  end

  describe 'status' do 
    it 'defaults to in progress' do
      @pound = Shelter.create!(foster_program: true, name: 'The Pound', city: "Denver", rank: 1)
      @snugglez = @pound.pets.create!(adoptable: true, age: 2, breed: "Tabby Cat", name: 'Snugglez')
      @huy = Application.create!(applicant_name: "Huy Phan", app_street: "123 Park Ave", app_city: "Denver", app_state: "CO", app_zip_code: "80205", description: "Im super cool and stuffy" )

      expect(@huy.status).to eq "In Progress"

      @huy.status = 1
      expect(@huy.status).to eq "Pending"
      @huy.status = 2
      expect(@huy.status).to eq "Accepted"
      @huy.status = 3
      expect(@huy.status).to eq "Rejected"
    end
  end

end