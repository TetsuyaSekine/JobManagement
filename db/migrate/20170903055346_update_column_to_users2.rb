class UpdateColumnToUsers2 < ActiveRecord::Migration[5.0]
  def change
    change_column :users, :section_id, :string
  end
end
