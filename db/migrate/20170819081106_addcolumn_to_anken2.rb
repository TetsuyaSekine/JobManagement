class AddcolumnToAnken2 < ActiveRecord::Migration[5.0]
  def change
    add_column :ankens, :last_update, :string, after: :anken_ball_cd
  end
end
