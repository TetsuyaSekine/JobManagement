class AddColumnCustomers < ActiveRecord::Migration[5.0]
  def change
    remove_column :customers, :customer_cd
  end
end
