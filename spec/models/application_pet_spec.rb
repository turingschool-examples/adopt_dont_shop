require "rails_helper"

RSpec.describe ApplicationPet, type: :model do
  describe "relationship" do
    it { should belong_to(:pet) }
    it { should belong_to(:application) }
  end

  describe "class methods" do
    xit "" do

    end
  end
end
