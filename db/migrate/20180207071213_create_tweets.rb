class CreateTweets < ActiveRecord::Migration[5.0]
  def change
    create_table :tweets do |t|
      t.integer :user_id
      t.integer :post_id
      t.text :content
      t.string :parameter
      t.integer :click, default: 0

      t.timestamps
    end
  end
end
