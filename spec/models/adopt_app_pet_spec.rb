require "rails_helper" 

RSpec.describe AdoptAppPet, type: :model do
  describe "relationships" do 
    it { should belong_to :adopt_app }
    it { should belong_to :pet }
  end
end 