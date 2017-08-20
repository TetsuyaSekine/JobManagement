class AddDetailsToAnkens < ActiveRecord::Migration[5.0]
  def change
    add_column :ankens, :anken_name, :string, after: :customer
  end
end
