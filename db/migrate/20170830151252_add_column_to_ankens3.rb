class AddColumnToAnkens3 < ActiveRecord::Migration[5.0]
  def change
    add_column :ankens, :budget_size, :string, after: :anken_summary
    add_column :ankens, :start_date, :string, after: :budget_size
    add_column :ankens, :end_date, :string, after: :start_date
  end
end
