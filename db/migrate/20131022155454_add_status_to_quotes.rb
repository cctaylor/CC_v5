class AddStatusToQuotes < ActiveRecord::Migration
  def change
    add_column :quotes, :status, :string, default: "NEW"
  end
end
