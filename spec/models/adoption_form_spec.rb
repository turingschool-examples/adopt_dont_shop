require 'rails_helper'

RSpec.describe AdoptionForm, type: :model do
  it 'exists' do
    form = create(:adoption_form)

    expect(form).to be_an(AdoptionForm)
    expect(form).to be_valid
  end

  describe 'relationships' do
    it {should have_many(:pet_adoption_forms) }
    it {should have_many(:pets).through(:pet_adoption_forms) }
  end

  describe 'validations' do
    it { should validate_presence_of :first_name }
    it { should validate_presence_of :last_name }
    it { should validate_presence_of :street_address }
    it { should validate_presence_of :city }
    it { should validate_presence_of :state }
    it { should validate_presence_of :zip_code }
    it { should validate_presence_of :description }
  end

  it 'has default value for description' do
    form = create(:adoption_form)

    expect(form.description).to eq("Describe home here")
  end
end
