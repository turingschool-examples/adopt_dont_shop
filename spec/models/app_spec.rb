require 'rails_helper'

RSpec.describe App do
  describe 'relationships' do
    it { should have_many(:pet_apps) }
    it { should have_many(:pets) }
  end
  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:street) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:state) }
    it { should validate_presence_of(:zip) }
    it { should validate_numericality_of(:zip) }
  end

  describe 'class methods' do

  end
  describe 'instance methods' do

  end
end