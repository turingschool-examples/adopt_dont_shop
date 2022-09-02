require 'rails_helper'

RSpec.describe PetApplications do
  it { should belong_to(:pet) }
  it { should belong_to(:application) }
end