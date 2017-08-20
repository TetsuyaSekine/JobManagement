class EditColumnToAnkens1 < ActiveRecord::Migration[5.0]
  def change
    change_column :ankens, :anken_ball_cd, :integer 
  end
end
