class ChangeColumnNull < ActiveRecord::Migration[5.2]
  def change
    change_column_null(:applications, :status, false)
  end
end
