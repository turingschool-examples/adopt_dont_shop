class AddGoodOwnertoApplications < ActiveRecord::Migration[5.2]
  def change
    add_column :applications, :good_owner, :string
  end
end
