class Application < ApplicationRecord
  enum status: {"In Progress" => 0 , "Pending" => 1, "Accepted" => 2, "Rejected" => 3}
end
