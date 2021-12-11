require "rails_helper"

RSpec.describe PetApplicant do

  describe 'class methods' do
    # it '#method' do
    # end

  end

  describe 'relationships' do
    it {should belong_to(:applicant)}
    it {should belong_to(:pet)}
  end

end
