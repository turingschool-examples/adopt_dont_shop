class AddGoodhomeToPetitions < ActiveRecord::Migration[5.2]
  def change
    add_column :petitions, :goodhome, :string, default: 'I love dogs'
  end
end
