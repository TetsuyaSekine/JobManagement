class RenameColumnToShains1 < ActiveRecord::Migration[5.0]
  def change
	rename_column :shains, :group, :group_team
  end
end
