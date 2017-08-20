class ChangeColumnToCustomer1 < ActiveRecord::Migration[5.0]
  def change
    change_column :customers, :customer, :string, null: false,default: ""
  end
end
