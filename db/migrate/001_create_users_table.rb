class CreateUsersTable < ActiveRecord::Migration
  def change
    # create users table
    create_table :users do |t|
      # credentials
      t.string :username, null: false
      t.string :password_hash

      # role
      t.boolean :admin, null: false, default: false
    end

    # enforce unique usernames at the database level
    add_index :users, :username, unique: true
  end
end