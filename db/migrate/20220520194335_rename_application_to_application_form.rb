class RenameApplicationToApplicationForm < ActiveRecord::Migration[5.2]
  def change
    rename_table :applications, :application_forms
  end
end
