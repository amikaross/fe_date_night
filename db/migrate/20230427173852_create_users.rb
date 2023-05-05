class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email
      t.string :password_digest
      t.string :googleid
      t.string :location
      t.string :lat
      t.string :long
      t.integer :radius, default: 50000
      t.string :encrypted_token
      t.string :encrypted_refresh_token

      t.timestamps
    end
  end
end
