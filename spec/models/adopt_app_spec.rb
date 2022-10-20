require "rails_helper" 

RSpec.describe AdoptApp, type: :model do
  describe "relationships" do 
    it { should have_many :adopt_app_pets }
    it { should have_many(:pets).through(:adopt_app_pets) }
  end
end 