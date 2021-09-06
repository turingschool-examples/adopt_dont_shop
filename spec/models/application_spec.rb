require 'rails_helper'


RSpec.describe Application do

  describe 'relationships' do
    it { should have_many(:pet_applications)}
    it { should have_many(:pets).through(:pet_applications) }
  end

  describe 'methods' do

      it 'can tell if no pets' do
        app = Application.create!(name: 'Hugh',
          city: 'Aurora',
          street_address: '300 quebec st',
          state: 'CO',
          zip: 12345
        )

        expect(app.dogs?).to eq(false)
      end
  end
end
