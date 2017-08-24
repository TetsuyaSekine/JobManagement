class CreateComments < ActiveRecord::Migration[5.0]
  def change
    create_table :comments do |t|
      t.integer :anken_id, :null => false
      t.string :ymd, :null => false
      t.text :anken_comment, :null => false
      t.string :last_update, :null => false

      t.timestamps
    end
  end
end
