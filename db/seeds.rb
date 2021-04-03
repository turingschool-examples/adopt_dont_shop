require 'factory_bot_rails'

PetApplication.destroy_all
Pet.destroy_all
Applicant.destroy_all
Shelter.destroy_all

FactoryBot.create(:shelter)
FactoryBot.create(:applicant)
FactoryBot.create(:pet)
FactoryBot.create(:pet_application)
FactoryBot.create(:pet_application)
FactoryBot.create(:pet_application)
FactoryBot.create(:pet_application)


# 3.times do
#   FactoryBot.create(:library) do |library|
#     FactoryBot.create_list(:book, 4, library: library)
#   end
# end
