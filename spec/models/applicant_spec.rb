require 'rails_helper'

RSpec.describe Applicant do
describe 'relationships' do
  it { should have_many(:pet_apps) }
  it { should have_many(:pets) }
end

describe 'class methods' do

end
describe 'instance methods' do

end
end