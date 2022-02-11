require 'rails_helper'

RSpec.describe PetApplication do
  it { should belong_to :application }
  it { should belong_to :pet }
end
