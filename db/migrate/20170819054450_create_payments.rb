class CreatePayments < ActiveRecord::Migration
  def change
    create_table :payments do |t|
      t.string :bank_ifsc_code
      t.integer :bank_account_number
      t.integer :amount
      t.string :merchant_transaction_ref
      t.date :transaction_date
      t.string :payment_gateway_merchant_reference
      t.string :payload_with_sha
      t.string :payload_to_pg

      t.timestamps null: false
    end
  end
end
