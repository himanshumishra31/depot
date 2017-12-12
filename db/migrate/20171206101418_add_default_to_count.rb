class AddDefaultToCount < ActiveRecord::Migration[5.1]
  def change
    change_column_default :categories, :count, 0
  end
end
