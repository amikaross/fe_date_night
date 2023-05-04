class CreateUserDates < ActiveRecord::Migration[5.2]
  def change
    create_table :user_dates do |t|
      t.references :user, foreign_key: true
      t.references :date, foreign_key: true
      t.boolean :owner 
    end
  end
end
