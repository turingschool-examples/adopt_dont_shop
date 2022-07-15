require 'rails_helper'

RSpec.describe ApplicantPet, type: :model do
  describe 'relationships' do
    it { should belong_to :applicant }
    it { should belong_to :pet }
  end
end
