require 'rails_helper'

RSpec.describe PetApplications do
  it { should belong_to(:pets) }
  it { should belong_to(:applications) }
end