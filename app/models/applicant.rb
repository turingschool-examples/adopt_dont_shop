class Applicant < ApplicationRecord
  has_one :address, dependent: :destroy
end
