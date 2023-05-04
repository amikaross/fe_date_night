class CreateDates < ActiveRecord::Migration[5.2]
  def change
    create_table :dates do |t|
      t.string :name
      t.string :place_id
      t.boolean :recurring
      t.time :time
      t.date :date
      t.string :notes
      t.timestamps
    end
  end
end
