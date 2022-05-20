class FixColumnApplicationFormId < ActiveRecord::Migration[5.2]
  def change
    rename_column :application_pets, :application_id, :application_form_id
  end
end
