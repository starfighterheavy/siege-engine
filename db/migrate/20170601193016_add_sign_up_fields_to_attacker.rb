class AddSignUpFieldsToAttacker < ActiveRecord::Migration[5.1]
  def change
    add_column :attackers, :new_registration_url, :string
    add_column :attackers, :create_registration_url, :string
    add_column :attackers, :registration_form_values, :text
    add_column :attackers, :registration_required, :boolean, default: false
  end
end
