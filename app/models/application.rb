class Application < ApplicationRecord
  has_one :applicant, dependant: :destroy
  has_many :pets

end
