require "rails_helper"

RSpec.describe ApplicationHelper, :type => :helper do
  describe "#us_states" do
    it "is an array of arrays of all state abbreviations plus dc" do
      expect(helper.us_states.class).to eq(Array)
      expect(helper.us_states.first).to eq(['AK, AK'])
    end
    
    it "returns all us states" do
      expect(helper.us_states.count).to eq(51)
    end
  end
end