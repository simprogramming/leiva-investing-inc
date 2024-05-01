class CreateStocks < ActiveRecord::Migration[7.0]
  def change
    create_table :stocks do |t|
      t.string :name
      t.string :symbol
      t.float :price
      t.string :status
      t.boolean :dividend, default: false
      t.float :yield
      t.string :distribution
      t.integer :position, uniq: true
      t.string :api_symbol

      t.timestamps
    end
  end
end
