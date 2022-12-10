class Application < ApplicationRecord
  enum status: {"in progress": 0, "pending": 1, "Accepted": 2, "Rejected": 3}

  validates_presence_of :name
  validates_presence_of :street_address
  validates_presence_of :city
  validates_presence_of :state
  validates_presence_of :zip_code
  validates_presence_of :description
  # before_validation :check_for_existence

# private
#   def check_for_existence(application)
#     self.attributes.each do |attr|
#       # return false if self[attr].nil?
#       if self[attr].nill?

#         redirect_to '/applications/new'
#     end
#   end  
end