class MoveStrikesFromSiegeToVolley < ActiveRecord::Migration[5.1]
  def change
    add_column :volleys, :strikes, :integer
    remove_column :sieges, :strikes
  end
end
