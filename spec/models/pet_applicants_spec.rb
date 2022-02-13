require 'rails_helper'

RSpec.describe PetApplicant, type: :model do
  describe 'relationships' do
    it { should belong_to(:pet)}
    it { should belong_to(:applicant)}
  end
  before(:each) do

  end
end
