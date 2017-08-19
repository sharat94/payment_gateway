class AddColumnToPayments < ActiveRecord::Migration
  def change
    add_column :payments, :status, :string
    add_column :payments, :message, :string
  end
end
