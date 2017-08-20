class CreateCodeMsts < ActiveRecord::Migration[5.0]
  def change
    create_table :code_msts do |t|
      t.string :category_cd
      t.string :category_name
      t.integer :contents_cd
      t.string :contents
      t.integer :del_flg
      t.text :remark

      t.timestamps
    end
  end
end
