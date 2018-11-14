class AddUidToSieges < ActiveRecord::Migration[5.2]
  def change
    add_column :sieges, :uid, :string
    add_column :attackers, :uid, :string
    add_column :targets, :uid, :string
    add_column :volleys, :uid, :string
    add_column :reports, :uid, :string
    add_column :results, :uid, :string
  end
end
