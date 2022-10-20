class RemoveAddressFromAdoptApps < ActiveRecord::Migration[5.2]
  def change
    remove_column :adopt_apps, :address, :string
  end
end
