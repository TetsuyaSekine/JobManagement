class AddColumnToUser1 < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :section_id, :integer
  end
end
