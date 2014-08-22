class CreateSeries < ActiveRecord::Migration
  def change
    create_table :series do |t|
      t.integer :tvdb_id
      t.string :name
      t.integer :runtime
      t.string :airtime

      t.timestamps
    end
  end
end
