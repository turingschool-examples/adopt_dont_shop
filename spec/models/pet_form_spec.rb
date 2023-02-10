require 'rails_helper'

RSpec.describe PetForm, type: :model do
  describe "relationships" do
    it {should belong_to :pet}
    it {should belong_to :form}
  end
end