class CreateProfiles < ActiveRecord::Migration[5.0]
  def change
    create_table :profiles do |t|
      t.text :content
      t.string :image_name
      t.string :area
      t.integer :gender, default: 0, null: false
      t.integer :interests, default: 0, null: false

      t.timestamps
    end
  end
end
