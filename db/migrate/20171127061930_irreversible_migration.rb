require_relative '20171124121337_create_distributors'

class IrreversibleMigration < ActiveRecord::Migration[5.1]
  def change
    revert CreateDistributors

    create_table(:distributors) do |t|
      t.string :zipcode
    end
  end
end
