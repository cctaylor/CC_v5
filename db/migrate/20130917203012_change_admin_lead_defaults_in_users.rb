class ChangeAdminLeadDefaultsInUsers < ActiveRecord::Migration
  def change
  	change_column :users, :admin, :boolean, default: false
  	change_column :users, :lead, :boolean, default: true
  end

end
