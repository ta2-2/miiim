class CreateShareUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :share_users do |t|
      t.string :provider
      t.string :uid
      t.string :nickname
      t.string :image_url
      t.integer :user_id
      t.string :token
      t.string :secret

      t.timestamps
    end
  end
end
