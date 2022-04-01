require 'rails_helper'

RSpec.describe Application, type: :model do
  describe "relationships" do
    it {should belong_to (:applicant)}
  end

  describe "validations" do
    it {should validate_presence_of (:pets)}
    it {should validate_presence_of (:status)}

  end
end
