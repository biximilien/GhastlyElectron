class CreateUsersTable < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username, null: false, default: ''
      t.string :password_hash
    end

    add_index :users, :username, unique: true

    create_table :messages do |t|
      t.string :content
    end
  end
end