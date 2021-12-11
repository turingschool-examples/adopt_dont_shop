require 'rails_helper'

RSpec.describe Address, type: :model do
  describe 'relationships' do
    it { validate_presence_of(:city) }
    it { validate_presence_of(:name) }
    it { validate_presence_of(:description) }
    it { should belong_to :application}
  end
end
