require 'rails_helper'

RSpec.describe Client, type: :model do
  describe'relationship' do
    it { should have_many(:adoption_forms) }
  end

  it 'exists' do
    client = create(:client)
    expect(client).to be_a(Client)
  end
end
