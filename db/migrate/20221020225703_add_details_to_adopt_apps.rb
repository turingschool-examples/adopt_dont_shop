class AddDetailsToAdoptApps < ActiveRecord::Migration[5.2]
  def change
    add_column :adopt_apps, :street_address, :string
    add_column :adopt_apps, :city, :string
    add_column :adopt_apps, :state, :string
    add_column :adopt_apps, :zip_code, :integer
  end
end
