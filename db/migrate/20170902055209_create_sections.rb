class CreateSections < ActiveRecord::Migration[5.0]
  def change
    create_table :sections do |t|
      t.string :section_cd
      t.string :section_name
      t.string :parent_cd
      t.integer :del_flg
      t.text :remark

      t.timestamps
    end
  end
end
