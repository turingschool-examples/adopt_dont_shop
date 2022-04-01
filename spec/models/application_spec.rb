require 'rails_helper'

RSpec.describe Application, type: :model do
  describe 'validations' do
    it { should validate_presence_of :name }
    it { should validate_presence_of :address }
    it { should validate_presence_of :description }
    it { should validate_presence_of :pet_names }
    it { should validate_presence_of :status }
  end
end