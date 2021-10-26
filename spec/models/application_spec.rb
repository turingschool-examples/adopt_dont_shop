require "rails_helper"

RSpec.describe Application, type: :model do
  describe "relationships" do
    it { should have_many :application_pets}
    it { should have_many(:pets).through(:application_pets)}
    # it { is_expected.to callback(Application).before(:validation).on([:create]) }
  end
end
