class ChangeDatatypeInterestsOfProfiles < ActiveRecord::Migration[5.0]
  def change
    change_column :profiles, :interests, :string
  end
end
