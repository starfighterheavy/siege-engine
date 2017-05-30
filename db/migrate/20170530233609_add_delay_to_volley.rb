class AddDelayToVolley < ActiveRecord::Migration[5.1]
  def change
    add_column :volleys, :delay, :integer, default: 0
  end
end
