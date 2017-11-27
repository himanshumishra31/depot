class AddDefaultValueToProducts < ActiveRecord::Migration[5.1]
  def change
    change_column_default :products, :enabled, :false
  end
end
