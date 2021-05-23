 require 'rails_helper'

 RSpec.describe Application, type: :model do
   context 'relationships' do
     it { should have_many(:pet_applications) }
     it { should have_many(:pets).through(:pet_applications) }
   end
 end
