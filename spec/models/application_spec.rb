require 'rails_helper'

RSpec.describe Application, type: :model do
  describe 'relationships' do
    it { should have_many :application_pets }
  end
  # 
  # describe 'validations' do
  #   it { should validate_presence_of(:name) }
  #   it { should validate_presence_of(:age) }
  #   it { should validate_numericality_of(:age) }
  # end
