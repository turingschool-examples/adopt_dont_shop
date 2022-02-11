class AddStateToApplicants < ActiveRecord::Migration[5.2]
  def change
    add_column :applicants, :state, :string
  end
end
