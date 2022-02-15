require 'rails_helper'

describe PetAdoptionForm do
  it { should belong_to(:pet) }
  it { should belong_to(:adoption_form) }
end
