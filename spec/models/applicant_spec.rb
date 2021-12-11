require "rails_helper"

RSpec.describe Applicant do

  describe 'class methods' do
    # it '#method' do
    # end

  end

  describe 'relationships' do
    it {should have_many(:pet_applicants)}
    it {should have_many(:pets).through(:pet_applicants)}
  end

  # describe 'validations' do
  #   it {should validate_presence_of(:name)}
  # end

end
