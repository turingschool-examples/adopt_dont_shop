class FixApplicationStatuses < ActiveRecord::Migration[5.2]
  def up
    Application.where(status: nil).update_all(status: 'in_progress')
    Application.where(status: 'In Progress').update_all(status: 'in_progress')
    Application.where(status: 'Pending').update_all(status: 'pending')
  end

  def down
    Application.where(status: 'in_progress').update_all(status: 'In Progress')
    Application.where(status: 'pending').update_all(status: 'Pending')
  end
end
