class CreatePositions < ActiveRecord::Migration[7.0]
  def change
    create_table :positions do |t|
      t.references :wallet, null: false, foreign_key: true
      t.references :stock, null: false, foreign_key: true
      t.float :size
      t.float :entry

      t.timestamps
    end
  end
end
