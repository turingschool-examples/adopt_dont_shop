class AddZipToApplicant < ActiveRecord::Migration[5.2]
  def change
    add_column :applicants, :zip, :integer
  end
end
