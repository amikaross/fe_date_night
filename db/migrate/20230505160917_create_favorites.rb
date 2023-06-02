class CreateFavorites < ActiveRecord::Migration[5.2]
  def change
    create_table :favorites do |t|
      t.string :google_id
      t.references :user, foreign_key: true
      t.string :name
    end
  end
end
