class CreateVolleys < ActiveRecord::Migration[5.1]
  def change
    create_table :volleys do |t|
      t.integer :siege_id
      t.string :name
      t.string :status
    end

    remove_column :sieges, :status

    add_column :reports, :volley_id, :integer
    add_column :results, :volley_id, :integer
  end
end
