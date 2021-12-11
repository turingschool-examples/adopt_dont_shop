require 'rails_helper'

RSpec.describe SurveyPet, type: :model do
  describe "validations" do 
    it { should belong_to :pet }
    it { should belong_to :survey }
  end
end