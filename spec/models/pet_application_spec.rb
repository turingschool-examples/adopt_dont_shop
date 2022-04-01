require "rails_helper"

RSpec.describe PetApplications, type: :model do
  describe "relationships" do
    it { should belong_to :pet }
    it { should belong_to :applications }
  end
end
