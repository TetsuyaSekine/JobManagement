class DropColumnToAnken1 < ActiveRecord::Migration[5.0]
  def change
    remove_columns :ankens, :customer
    remove_columns :ankens, :anken_status
    remove_columns :ankens, :integer
    remove_columns :ankens, :tanto
    remove_columns :ankens, :anken_ball
  end
end
