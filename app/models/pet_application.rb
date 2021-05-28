class PetApplication < ApplicationRecord
  belongs_to :pet
  belongs_to :application

  def approved_or_declined
    if was_approved == false
      p " was declined"
    elsif was_approved == true
      p " was approved"
    end  
  end



end
