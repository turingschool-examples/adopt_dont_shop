class Application < ApplicationRecord
  has_one :applicant, dependent: :destroy
  has_many :pets

end
