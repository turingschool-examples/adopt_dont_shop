class ApplicationPet < ApplicationRecord
  belongs_to :application
  belongs_to :pet
  # after_create :update_status

  # def update_status

    # self.application.update!(:status => "Pending")

    # self.application.status = "Pending"
  # end
end
