require "rails_helper"

RSpec.describe Application, type: :model do
  describe "relationships" do
    it { should have_many(:pet_applications) }
    it { should have_many(:pets).through(:pet_applications) }
  end

  describe "validations" do
    it { should define_enum_for(:status).with(["In Progress", "Pending", "Approved", "Rejected"]) }
  end
end
