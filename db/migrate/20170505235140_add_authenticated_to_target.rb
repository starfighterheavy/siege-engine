class AddAuthenticatedToTarget < ActiveRecord::Migration[5.1]
  def change
    add_column :targets, :authenticated, :boolean, default: true
  end
end
