require 'rails_helper'

RSpec.describe Applicant, type: :model do
    describe 'validations' do
        it { should validate_presence_of(:name) }
        it { should validate_presence_of(:address) }
        it { should validate_presence_of(:city) }
        it { should validate_presence_of(:state) }
        it { should validate_presence_of(:zip) }
        it { should validate_presence_of(:names_pets_wanted) }
        it { should validate_presence_of(:description) }
        it { should validate_presence_of(:application_status) }
    end
end