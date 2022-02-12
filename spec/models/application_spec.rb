RSpec.describe Application, type: :model do
  describe "relationships" do
    it {should have_many :application_pets}
  end
end
