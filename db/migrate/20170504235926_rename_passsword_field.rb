class RenamePassswordField < ActiveRecord::Migration[5.1]
  def change
    rename_column :attackers, :passsword_field, :password_field
  end
end
