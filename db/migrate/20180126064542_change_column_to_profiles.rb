class ChangeColumnToProfiles < ActiveRecord::Migration[5.0]
  
    # 変更内容
  def up
    change_column :profiles, :gender, :intege, default: 0, null: true
    change_column :profiles, :interests, :string, default: 0, null: true
  end

  # 変更前の状態
  def down
    change_column :profiles, :gender, :intege, default: 0, null: false
    change_column :profiles, :interests, :integer, default: 0, null: false
  end
  
end
