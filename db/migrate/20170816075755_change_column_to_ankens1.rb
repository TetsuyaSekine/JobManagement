class ChangeColumnToAnkens1 < ActiveRecord::Migration[5.0]
  def change
    rename_column :ankens, :customer_cd, :customer_id
    rename_column :ankens, :tanto_cd, :tanto_id
  end
end
