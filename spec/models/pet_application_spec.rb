require 'rails_helper'

RSpec.describe PetApplication do
  it { should belong_to(:pet) }
  it { should belong_to(:application) }

end