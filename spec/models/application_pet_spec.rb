require 'rails_helper'

# ApplicationPets
# belongs_to :pets
# belongs_to :applications

RSpec.describe ApplicationPet, type: :model do
  describe 'relationships' do
    it {should belong_to(:pet)}
    it {should belong_to(:application)}
  end
end
