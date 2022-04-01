require 'rails_helper'

RSpec.describe ApplicationsPet, type: :model do
  describe "relationships" do
    it {should belong_to :pet}
    it {should belong_to :application}
  end
end
