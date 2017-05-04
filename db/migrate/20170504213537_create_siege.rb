class CreateSiege < ActiveRecord::Migration[5.1]
  def change
    create_table :access_keys do |t|
      t.string :access_key_id
      t.string :encrypted_secret_access_key
      t.string :encrypted_secret_access_key_iv
      t.integer :max_strikes
      t.integer :max_sieges
      t.timestamps
    end

    add_index(:access_keys, :access_key_id)

    create_table :sieges do |t|
      t.integer :access_key_id
      t.integer :strikes
      t.timestamps
    end

    add_index(:sieges, :access_key_id)

    create_table :attackers do |t|
      t.integer :siege_id
      t.string :username
      t.string :encrypted_password
      t.string :encrypted_password_iv
      t.string :username_field
      t.string :passsword_field
      t.string :login_url
      t.text :cookie
      t.timestamps
    end

    add_index(:attackers, :siege_id)

    create_table :targets do |t|
      t.integer :siege_id
      t.integer :user_id
      t.string :method
      t.text :url
      t.text :body
      t.string :content_type
      t.timestamps
    end

    add_index(:targets, :siege_id)
    add_index(:targets, :user_id)
    add_index(:targets, :url_id)

    create_table :results do |t|
      t.integer :siege_id
      t.integer :target_id
      t.integer :code
      t.integer :time
      t.timestamps
    end

    add_index(:results, :siege_id)
    add_index(:results, :target_id)
  end
end
