class CreateIcalSettings < ActiveRecord::Migration
  def change
    create_table :ical_settings do |t|
      t.belongs_to :user, index: true
      t.integer :start_offset
      t.integer :end_offset
      t.integer :summary_format
      t.integer :location_format
      t.integer :description_format

      t.timestamps
    end
  end
end
