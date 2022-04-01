require 'rails_helper'

RSpec.describe Applicant, type: :model do
  describe "relationships" do
    it {should have_many (:applications)}
  end

  describe "validations" do
    it {should validate_presence_of (:name)}
    it {should validate_presence_of (:street_address)}
    it {should validate_presence_of (:city)}
    it {should validate_presence_of (:state)}
    it {should validate_presence_of (:zipcode)}
    it {should validate_presence_of (:description)}
  end
end
