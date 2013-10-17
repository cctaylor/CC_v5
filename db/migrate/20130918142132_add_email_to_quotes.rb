class AddEmailToQuotes < ActiveRecord::Migration
  def change
  	add_column :quotes, :email, :string
  	add_index :quotes, [:email, :created_at]
  end
end
