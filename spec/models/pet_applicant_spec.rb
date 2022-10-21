require 'rails_helper'

RSpec.describe PetApplicant, type: :model do 
  describe 'relationship' do 
    it { should belong_to :pet }
    it { should belong_to :applicant }
  end

  describe 'validations' do 
    it { validate_presence_of :pet_id }
    it { validate_presence_of :applicant_id }
  end
end