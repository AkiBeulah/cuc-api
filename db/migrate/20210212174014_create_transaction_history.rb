class CreateTransactionHistory < ActiveRecord::Migration[6.0]
  def change
    create_table :transaction_histories do |t|
      t.integer :amount
      t.string :flw_ref
      t.string :tx_ref
      t.string :transaction_id
      t.string :transaction_type
      t.string :transaction_title

      t.belongs_to :user

      t.timestamps
    end
  end
end
