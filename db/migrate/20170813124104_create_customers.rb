class CreateCustomers < ActiveRecord::Migration[5.0]
  def change
    create_table :customers do |t|
      t.integer :customer_cd
      t.string :customer
      t.integer :del_flg

      t.timestamps
    end
  end
end
