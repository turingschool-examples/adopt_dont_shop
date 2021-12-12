require 'rails_helper'

RSpec.describe Application, type: :model do
  it {should have_many(:pet_applications)}
end
