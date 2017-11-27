class IrreversibleMigration < ActiveRecord::Migration[5.1]
  def up
    create_table :distributors do |t|
      t.string :zipcode
    end

    change_column :distributors, :zipcode, :integer
  end

  def down
    change_column :distributors, :zipcode, :string

    drop_table :distributors
  end
end
