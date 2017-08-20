class CreateAnkens < ActiveRecord::Migration[5.0]
  def change
    create_table :ankens do |t|
      t.integer :customer_cd
      t.string :customer
      t.text :anken_summary
      t.integer :anken_status_cd
      t.string :anken_status
      t.integer :tanto_cd
      t.string :tanto
      t.string :anken_ball_cd
      t.string :integer
      t.string :anken_ball
      t.timestamp :tourokudate
      t.timestamp :koushindate
      t.text :remark

      t.timestamps
    end
  end
end
