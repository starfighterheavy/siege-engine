class AddResponseBodyToResults < ActiveRecord::Migration[5.1]
  def change
    add_column :results, :body, :text
  end
end
