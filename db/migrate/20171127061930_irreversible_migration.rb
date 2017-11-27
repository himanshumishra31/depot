class IrreversibleMigration < ActiveRecord::Migration[5.1]
  def change
    drop_table :distributors do |t|
      t.string :zipcode
    end
  end
end
