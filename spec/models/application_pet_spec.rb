require 'rails_helper'

RSpec.describe ApplicationPet, type: :model do
  it { should belong_to :pet }
  it { should belong_to :application }
end
