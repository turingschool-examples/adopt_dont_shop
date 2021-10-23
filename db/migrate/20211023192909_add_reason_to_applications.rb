class AddReasonToApplications < ActiveRecord::Migration[5.2]
  def change
    add_column :applications, :reason, :string
  end
end
