class AddColumnToShains1 < ActiveRecord::Migration[5.0]
  def change
	add_column :shains, :section_cd, :string, after: :name
	add_column :shains, :group_cd, :string, after: :pb
  end
end
