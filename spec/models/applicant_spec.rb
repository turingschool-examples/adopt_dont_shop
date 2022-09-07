require 'rails_helper'

RSpec.describe Applicant, type: :model do
  describe 'relationships' do
    it { should have_many(:applicant_pets) }
    it { should have_many(:pets).through (:applicant_pets) }
  end

  describe 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:street_address) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_length_of(:state).is_equal_to(2) }
    it { should validate_presence_of(:zip) }
    it { should validate_numericality_of(:zip) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:status) }
    it do
      should validate_inclusion_of(:status).
      in_array(['In Progress', 'Pending', 'Approved', 'Rejected'])
    end
  end
end