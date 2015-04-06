require './lib/ghastly/electron'

class CreateServersTable < ActiveRecord::Migration

  def change
    create_table :servers do |t|
      t.string  :host, null: false, default: Ghastly::Electron::Default::HOST
      t.integer :port, null: false, default: Ghastly::Electron::Default::PORT
    end

    add_index :servers, :port, unique: true
  end
end