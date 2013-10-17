class ChangeIndexOnQuote < ActiveRecord::Migration
  def up
  	remove_index :quotes, [:email, :created_at]
  	add_index :quotes, [:user_id, :created_at]
  end

  def down
  	remove_index :quotes, [:user_id, :created_at]
  	add_index :quotes, [:email, :created_at]
  end
end
