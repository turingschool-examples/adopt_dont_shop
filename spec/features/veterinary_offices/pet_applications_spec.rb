require 'rails_helper'
# ApplicationsPet
RSpec.describe PetApplication, type: :model do
  describe "relationships" do
    it {should belong_to :pet}
    it {should belong_to :application}
  end
end
