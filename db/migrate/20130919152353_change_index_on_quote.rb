class ChangeIndexOnQuote < ActiveRecord::Migration
  def up
  	add_index :quotes, [:user_id, :created_at]
  end

  def down
  	remove_index :quotes, [:user_id, :created_at]
  end
end
