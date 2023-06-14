class CreateUserAppointments < ActiveRecord::Migration[5.2]
  def change
    create_table :user_appointments do |t|
      t.references :user, foreign_key: true
      t.references :appointment, foreign_key: true
      t.boolean :owner 
      t.string :status, default: "none"
    end
  end
end
