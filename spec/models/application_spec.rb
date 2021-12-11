require 'rails_helper'

RSpec.describe Application, type: :model do
  describe 'relationships' do
    it { validate_presence_of(:city)}
    it { validate_presence_of(:zip)}
    it { validate_presence_of(:street)}
    it { validate_presence_of(:state)}
    it { validate_presence_of(:name)}
    it { validate_presence_of(:description)}
    it { should have_many :addresses }
    it { should have_many(:pets).through(:application_pets)}
  end
end
