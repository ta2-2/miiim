class AddPostOnToPosts < ActiveRecord::Migration[5.0]
  def change
    add_column :posts, :post_on, :boolean, default: false, null: false
  end
end
