class Application < ApplicationRecord
  enum status: {"in progress": 0, "pending": 1, "Accepted": 2, "Rejected": 3}

end