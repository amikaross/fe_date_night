class CreateAppointments < ActiveRecord::Migration[5.2]
  def change
    create_table :appointments do |t|
      t.string :name
      t.string :place_id
      t.string :place_name
      t.boolean :recurring
      t.time :time
      t.date :date
      t.string :notes
      t.timestamps
    end
  end
end
