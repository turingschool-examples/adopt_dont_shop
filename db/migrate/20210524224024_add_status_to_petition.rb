class AddStatusToPetition < ActiveRecord::Migration[5.2]
  def change
    add_column :petitions, :status, :string, default: "In Progress"
  end
end
