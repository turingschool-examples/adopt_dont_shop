require 'rails_helper'

RSpec.describe Application, type: :model do
  
  describe 'relationship' do
    
  end

  describe 'instance methods' do
    it 'displays address' do
      @application = Application.create!(name: 'Joe', street_address: "123 street lane", city: "denver", state: "co", zip_code: "80218", description: "I like dogs", pet_names: "kona", status: "pending" )

      expect(@application.address).to eq("#{@application.street_address} "+
                                          "#{@application.city} "+
                                          "#{@application.state} "+
                                          "#{@application.zip_code}")
    end
  end
end