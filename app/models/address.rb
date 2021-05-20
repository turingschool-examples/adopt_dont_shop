class Address < ApplicationRecord
  belongs_to :applicant, foreign_key: true
end
