class AddCountToCategories < ActiveRecord::Migration[5.1]
  def change
    add_column :categories, :count, :integer
  end
end
