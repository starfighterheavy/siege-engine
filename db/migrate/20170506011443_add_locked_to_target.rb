class AddLockedToTarget < ActiveRecord::Migration[5.1]
  def change
    add_column :targets, :locked_at, :datetime
  end
end
