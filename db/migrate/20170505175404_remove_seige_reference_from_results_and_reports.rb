class RemoveSeigeReferenceFromResultsAndReports < ActiveRecord::Migration[5.1]
  def change
    remove_column :reports, :siege_id
    remove_column :results, :siege_id
  end
end
