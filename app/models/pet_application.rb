class PetApplication < ApplicationRecord
  belongs_to :application
  belongs_to :pet

  enum status: {"pending": 0, "accepted": 1, "rejected": 2}
end