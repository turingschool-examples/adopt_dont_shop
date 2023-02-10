class Form < ApplicationRecord
  has_many :pet_forms
  has_many :pets, through: :pet_forms

  enum status: ["In Progess", "Pending", "Accepted", "Rejected"]
end