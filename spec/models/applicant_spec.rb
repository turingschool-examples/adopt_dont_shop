require 'rails_helper'

RSpec.describe Applicant, type: :model do 
    describe 'relationships' do 
        it { should have_many :applications }
    end
end