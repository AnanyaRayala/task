class AddColumnsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :leave_app_status, :string
    add_column :users, :leaves_credited, :integer
    add_column :users, :leaves_taken, :integer
    add_column :users, :leave_balance, :integer, default: 10
  end
end
