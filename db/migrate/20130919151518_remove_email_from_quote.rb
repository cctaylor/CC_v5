class RemoveEmailFromQuote < ActiveRecord::Migration
  def up
    remove_column :quotes, :email
  end

  def down
    add_column :quotes, :email, :string
  end
end
