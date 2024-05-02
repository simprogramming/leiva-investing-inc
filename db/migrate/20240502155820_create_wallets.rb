class CreateWallets < ActiveRecord::Migration[7.0]
  def change
    create_table :wallets do |t|
      t.float :cash, default: 100_000
      t.string :name
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
