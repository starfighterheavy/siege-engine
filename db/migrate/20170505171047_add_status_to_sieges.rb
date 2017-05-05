class AddStatusToSieges < ActiveRecord::Migration[5.1]
  def change
    add_column :sieges, :status, :string
  end
end
