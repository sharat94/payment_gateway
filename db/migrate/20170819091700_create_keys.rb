class CreateKeys < ActiveRecord::Migration
  def change
    create_table :keys do |t|
      t.string :main_key
      t.string :main_iv

      t.timestamps null: false
    end
  end
end
