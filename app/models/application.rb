class Application < ApplicationRecord
  validates :applicant_name, presence: true
  validates :street_address, presence: true
  validates :city, presence: true
  validates :state, presence: true
  validates :zip_code, presence: true
  validates :status, presence: true


  has_many :pet_applications
  has_many :pets, through: :pet_applications

  def update_status
    if pet_applications.pluck(:condition).all? { |condition| condition == "Approved" }
      self.update(status: "Approved")
      self.save
      pets = pet_applications.map do |pet_app|
        pet_app.pet
      end
      pets.each do |pet|
        pet.pet_adopted
      end
    elsif
      pet_applications.pluck(:condition).include?("Pending") == true
    else
      pet_applications.pluck(:condition).any? { |condition| condition == "Denied" } 
      self.update(status: "Rejected")
      self.save
    end
  end

  def find_pet_apps
    pet_apps = PetApplication.where("application_id = #{self.id}")
  end
end

# <% @application.pets.each do |pet| %>
#   <h3><%= pet.name %></h3>
#     <% if PetApplication.joins(:pet).where("pet_id = #{pet.id} and application_id = #{@application.id}").pluck(:condition).first == "Pending" %>
#     <p><%= link_to "Approve this Pet!", "/admin/applications/#{PetApplication.joins(:pet).where("pet_id = #{pet.id}").pluck(:id).first}?condition_update=Approved", id: "Approve #{pet.id}", method: :post %> 
#     <p><%= link_to "Reject this Pet", "/admin/applications/#{PetApplication.joins(:pet).where("pet_id = #{pet.id}").pluck(:id).first}?condition_update=Denied", id: "Reject #{pet.id}", method: :post %></p>
#     <% elsif PetApplication.joins(:pet).where("pet_id = #{pet.id} and application_id = #{@application.id}").pluck(:condition).first == "Approved" %>
#     <p><%= "The application for this pet has been approved." %></p>
#     <% else %>
#     <p><%= "The application for this pet has been denied." %></p>
#     <% end %>
#   <% end %>