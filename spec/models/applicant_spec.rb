require 'rails_helper'

RSpec.describe Applicant, type: :model do
  describe 'relationships' do
    it { should have_many(:applicant_pets) }
    it { should have_many(:pets).through (:applicant_pets) }
  end
end