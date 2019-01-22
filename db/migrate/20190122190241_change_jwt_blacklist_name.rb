class ChangeJwtBlacklistName < ActiveRecord::Migration[5.2]
  def change
    rename_table :jwt_blacklist, :jwt_blacklists
  end
end
