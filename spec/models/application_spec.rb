require 'rails_helper'

RSpec.describe Application do
  describe "relationships" do
    it {should have_many(:application_pets)}
    it {should have_many(:pets).through(:application_pets)}
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:address) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:status) }
  end
end