class ChangeColumnTypeRatings < ActiveRecord::Migration[5.1]
  def change
    change_column :ratings, :value, :decimal, precision: 2, scale: 1
  end
end
