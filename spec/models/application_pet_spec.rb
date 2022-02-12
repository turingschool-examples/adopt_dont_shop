require 'rails_helper'

RSpec.describe Application, type: :model do 
    describe 'relationships' do 
        it { should belong_to(:pets)}
        it { should belong_to(:application)}
    end
end