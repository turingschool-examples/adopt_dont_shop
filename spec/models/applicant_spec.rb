require 'rails_helper'
require 'rails_helper'

RSpec.describe Applicant, type: :model do
  describe 'relationships' do
    # it { should have_many(:applicant_pets) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:street_address) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_numericality_of(:zip_code) }
    it { should validate_length_of(:zip_code).is_equal_to(5) }
    it { should validate_presence_of(:applicant_bio) }
    it { should allow_value('In Progress').for(:application_status) }
    it { should allow_value('Pending').for(:application_status) }
    it { should allow_value('Accepted').for(:application_status) }
    it { should allow_value('Rejected').for(:application_status) }
  end

end
