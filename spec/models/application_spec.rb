require "rails_helper"


RSpec.describe Application, type: :model do
  describe "relationships" do
    it { should have_many(:pets).through(:application_pets)}
    it { should validate_presence_of(:name)}
    it { should validate_presence_of(:street)}
    it { should validate_presence_of(:city)}
    it { should validate_presence_of(:state)}
    it { should validate_presence_of(:zip)}
    it { should validate_presence_of(:description)}
  end
end
