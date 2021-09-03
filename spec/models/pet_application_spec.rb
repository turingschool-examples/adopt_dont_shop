require "rails_helper"

RSpec.describe PetApplication do
  describe "relationships" do
    it { should have_many :pets}
    it { should have_many :applications}
  end
end
