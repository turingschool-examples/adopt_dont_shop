class AddCityToApplicant < ActiveRecord::Migration[5.2]
  def change
    add_column :applicants, :city, :string
  end
end
