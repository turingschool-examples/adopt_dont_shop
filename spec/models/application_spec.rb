require 'rails_helper'

RSpec.describe Application do
  it {should have_many :pets}
  it { should have_many :application_pets}
end