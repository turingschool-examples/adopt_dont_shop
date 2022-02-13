class AddDefaultValueToDescriptionOnApplication < ActiveRecord::Migration[5.2]
  def change
    change_column_default :applications, :description, "Incomplete"
  end
end
