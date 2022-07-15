RSpec.describe ApplicantPet do
  describe "relationships" do
    it {should belong_to(:applicant)}
    it {should belong_to(:pet)}
  end
end