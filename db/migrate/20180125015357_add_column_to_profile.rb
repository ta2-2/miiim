class AddColumnToProfile < ActiveRecord::Migration[5.0]
  def change
    add_column :profiles, :level, :integer, default: 0
  end
end
