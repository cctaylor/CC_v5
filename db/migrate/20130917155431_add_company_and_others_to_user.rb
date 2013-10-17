class AddCompanyAndOthersToUser < ActiveRecord::Migration
  def change
    add_column :users, :lead, :boolean
    add_column :users, :address1, :string
    add_column :users, :address2, :string
    add_column :users, :city, :string
    add_column :users, :state, :string
    add_column :users, :zip, :string
    add_column :users, :zip4, :string
  end
end
