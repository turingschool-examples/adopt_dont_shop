require 'rails_helper'

RSpec.describe PetApp do
describe 'relationships' do
  it { should belong_to(:pet) }
  it { should belong_to(:applicant) }
end

describe 'class methods' do

end
describe 'instance methods' do

end
end