class AddColumnAnkens1 < ActiveRecord::Migration[5.0]
  def change
    remove_column :ankens, :tourokudate
    remove_column :ankens, :koushindate
  end
end
