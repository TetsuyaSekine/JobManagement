class CreateTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :detail
      t.date :due
      t.integer :status
      t.text :remark

      t.timestamps
    end
  end
end
