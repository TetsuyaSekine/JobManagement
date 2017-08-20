class CreateTantos < ActiveRecord::Migration[5.0]
  def change
    create_table :tantos do |t|
      t.string :tanto_name
      t.integer :del_flg

      t.timestamps
    end
  end
end
