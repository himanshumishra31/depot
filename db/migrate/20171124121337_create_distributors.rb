class CreateDistributors < ActiveRecord::Migration[5.1]
  def change
    create_table :distributors do |t|
      t.string :zipcode
    end
  end
end
