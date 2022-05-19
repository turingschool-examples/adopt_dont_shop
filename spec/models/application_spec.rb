require 'rails_helper'

RSpec.describe Application, type: :model do
  describe "relationships" do
    it {should have_many(:pet).through(:pet_applications)}
    it {should have_many(:pet_applications)}
  end
end
