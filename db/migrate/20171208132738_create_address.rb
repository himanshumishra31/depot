class CreateAddress < ActiveRecord::Migration[5.1]
  def change
    create_table :addresses do |t|
      t.string :state
      t.string :city
      t.string :country
      t.integer :pincode
      t.belongs_to :user, index: true
      t.timestamps
    end
  end
end
