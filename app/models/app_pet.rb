class AppPet < ApplicationRecord
  belongs_to :app
  belongs_to :pet
end 