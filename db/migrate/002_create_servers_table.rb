class CreateServersTable < ActiveRecord::Migration

  DEFAULT_HOST = 'localhost'
  DEFAULT_PORT = 25252

  def change
    create_table :servers do |t|
      t.string  :host, null: false, default: DEFAULT_HOST
      t.integer :port, null: false, default: DEFAULT_PORT
    end

    add_index :servers, :port, unique: true
  end
end