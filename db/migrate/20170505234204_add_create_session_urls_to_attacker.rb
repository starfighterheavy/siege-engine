class AddCreateSessionUrlsToAttacker < ActiveRecord::Migration[5.1]
  def change
    rename_column :attackers, :login_url, :new_session_url
    add_column :attackers, :create_session_url, :string
  end
end
