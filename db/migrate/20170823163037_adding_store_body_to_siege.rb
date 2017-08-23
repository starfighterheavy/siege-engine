class AddingStoreBodyToSiege < ActiveRecord::Migration[5.1]
  def change
    add_column :sieges, :store_body, :boolean
  end
end
