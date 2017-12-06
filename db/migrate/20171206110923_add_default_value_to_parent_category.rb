class AddDefaultValueToParentCategory < ActiveRecord::Migration[5.1]
  def change
    change_column_default :categories, :parent_category_id, :null
  end
end
