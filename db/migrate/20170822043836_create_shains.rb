class CreateShains < ActiveRecord::Migration[5.0]
  def change
    create_table :shains do |t|
      t.string :shain_id
      t.string :name
      t.string :section
      t.string :pb
      t.string :group
      t.string :grade
      t.string :email
      t.string :charge
      t.integer :del_flg

      t.timestamps
    end
  end
end
