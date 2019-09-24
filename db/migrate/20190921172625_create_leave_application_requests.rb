class CreateLeaveApplicationRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :leave_application_requests do |t|
      t.belongs_to :user
      t.string :user_name
      t.datetime :apply_date
      t.datetime :from_date
      t.datetime :to_date
      t.text :reason
      t.string :reporting_head
      t.integer :leave_status, default: 12
      t.boolean :active, default: true


      t.timestamps
    end
  end
end
