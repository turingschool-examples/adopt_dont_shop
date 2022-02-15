require 'rails_helper'

RSpec.describe Application, type: :model do
  describe "relationships" do
    it { should have_many(:pet_application)}
    it { should have_many(:pets).through(:pet_application) }
  end
end
