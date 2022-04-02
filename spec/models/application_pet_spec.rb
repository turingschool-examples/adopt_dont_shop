require 'rails_helper'

RSpec.describe ApplicationPet, type: :model do

  describe "relationships" do
    it { should belong_to :application }
    it { should belong_to :pet }
  end



  # describe "validations"
  #
  #
  # describe "class methods"
  #
  #
  # describe "instance methods"

end
