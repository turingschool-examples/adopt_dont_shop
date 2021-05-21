# spec/models/application_spec
require 'rails_helper'

RSpec.describe Application, type: :model do
  # describe 'relationships' do
  #   it { should belong_to(:shelter) }
  # end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:street_address) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_numericality_of(:zip_code) }
  end
end
