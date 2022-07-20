require 'rails_helper'

RSpec.describe PetApplication, type: :model do
  describe 'relationships' do
    it { should belong_to(:application) }
    it { should belong_to(:pet) }
  end

  describe 'validations' do
    it { should allow_value("In Progress").for(:status) }
    it { should allow_value("Pending").for(:status) }
    it { should allow_value("Accepted").for(:status) }
    it { should allow_value("Rejected").for(:status) }
    it { should_not allow_value("Something").for(:status) }
  end
end
