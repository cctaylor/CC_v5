class CreateQuotes < ActiveRecord::Migration
  def change
    create_table :quotes do |t|
      t.string :item
      t.string :paper
      t.string :fold
      t.string :color1
      t.string :color2
      t.integer :quantity
      t.string :message

      t.timestamps
    end
  end
end
