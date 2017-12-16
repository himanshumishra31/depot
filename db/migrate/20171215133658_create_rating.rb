class CreateRating < ActiveRecord::Migration[5.1]
  def change
    create_table :ratings do |t|
      t.integer :user_id
      t.integer :value
      t.integer :product_id
      t.timestamps
    end
  end
end
