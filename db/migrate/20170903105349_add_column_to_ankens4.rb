class AddColumnToAnkens4 < ActiveRecord::Migration[5.0]
  def change
    add_column :ankens, :section_cd, :string, after: :id
    add_column :ankens, :pm, :string, after: :end_date
    add_column :ankens, :asign_info, :string, after: :pm
  end
end
