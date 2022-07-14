require 'rails_helper'

RSpec.describe "Applicant" type: :model do
    # describe 'relationships' do
    #     it { should belong_to(:shelter) }
    #     end
    
    describe 'validations' do
        it { should validate_presence_of(:name) }
        it { should validate_presence_of(:address) }
        it { should validate_presence_of(:name_of_pets) }
        it { should validate_presence_of(:description) }
        it { should validate_presence_of(:application_status) }
        end
end