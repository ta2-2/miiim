class AddColumnToProfiles < ActiveRecord::Migration[5.0]
  def change
    add_column :profiles, :birth_date, :date
    add_column :profiles, :job, :string
  end
end
