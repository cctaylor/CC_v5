class AddQuoteNameToQuotes < ActiveRecord::Migration
  def change
    add_column :quotes, :quote_name, :string
  end
end
