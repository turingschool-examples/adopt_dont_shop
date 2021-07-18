require 'rails_helper'

RSpec.describe AdoptionApplication do
  describe 'relationships' do
    it { should have_many :adoption_application_pets }
    it { should have_many(:pets).through(:adoption_application_pets) }
  end

  # describe 'validations' do
  #   it { should validate_presence_of(:name) }
  #   it { should validate_presence_of(:street_address) }
  #   it { should validate_presence_of(:city) }
  #   it { should validate_presence_of(:state) }
  #   it { should validate_numericality_of(:zip_code) }
  # end
end
