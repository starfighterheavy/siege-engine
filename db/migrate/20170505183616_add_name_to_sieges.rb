class AddNameToSieges < ActiveRecord::Migration[5.1]
  def change
    add_column :sieges, :name, :string
  end
end
