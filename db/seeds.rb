require 'factory_bot_rails'

Pet.destroy_all
Applicant.destroy_all

2.times do
  FactoryBot.create(:applicant) do |applicant|
    FactoryBot.create_list(:pet, 3, applicant: applicant)
  end
end

2.times do
  FactoryBot.create(:applicant) do |applicant|
    FactoryBot.create_list(:pet, 1, applicant: applicant)
  end
end

1.times do
  FactoryBot.create(:applicant) do |applicant|
    FactoryBot.create_list(:pet, 2, applicant: applicant)
  end
end
