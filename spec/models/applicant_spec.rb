require "rails_helper"

RSpec.describe Applicant, type: :model do
  describe "relationships" do
    it { should have_many :applicants_pets}
    it {should have_many(:pets).through(:applicants_pets)}
  end
end
