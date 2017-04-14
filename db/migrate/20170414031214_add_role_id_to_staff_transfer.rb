class AddRoleIdToStaffTransfer < ActiveRecord::Migration
  def change
  	add_column :staff_transfers, :role_id, :integer
  end
end
