class CreateApplyingApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :applying_applications do |t|
      t.references :pet, foreign_key: true
      t.references :applicant, foreign_key: true

      t.boolean :in_progress
      t.boolean :pending
      t.boolean :accepted
      t.boolean :rejected
      t.string :description

      t.timestamps
    end
  end
end
