require 'rails_helper'

RSpec.describe Applicant, type: :model do
  describe 'relatioinships' do
    it { should have_many(:applicant_pets) }
  end
end
