class AddBalanceToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :balance, :float, :null => false, default: 0, precision: 2
    add_column :users, :rfuid, :string, unique: :true
    add_column :users, :rfuid_pin, :string

    add_column :users, :card_enabled, :boolean, null: false, default: false
    add_column :users, :spending_limit, :float, null: false, default: 0
    add_column :users, :last_transaction, :timestamp
  end
end
