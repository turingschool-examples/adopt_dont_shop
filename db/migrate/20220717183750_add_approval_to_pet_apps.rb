class AddApprovalToPetApps < ActiveRecord::Migration[5.2]
  def change
    add_column :pet_apps, :approval, :string
  end
end
