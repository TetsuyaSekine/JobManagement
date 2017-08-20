class CreateOptionToAnken1 < ActiveRecord::Migration[5.0]
  def change
    change_column :ankens, :customer_id, :integer, null: false,default: 0
    change_column :ankens, :anken_name, :string, null: false,default: ""
    change_column :ankens, :anken_summary, :text, null: false,default: ""
    change_column :ankens, :anken_status_cd, :integer, null: false,default: 0
    change_column :ankens, :tanto_id, :integer, null: false,default: 0
    change_column :ankens, :anken_ball_cd, :integer, null: false,default: 0
  end
end
