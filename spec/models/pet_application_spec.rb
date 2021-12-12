require 'rails_helper'

RSpec.describe PetApplication, type: :model do
  it {should belong_to(:pet)}
  it {shoudl belong_to(:application)}
end
