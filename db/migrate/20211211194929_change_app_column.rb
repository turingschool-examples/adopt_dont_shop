class ChangeAppColumn < ActiveRecord::Migration[5.2]
  def change
    change_column :apps, :status, :integer, default: 0
  end
end
