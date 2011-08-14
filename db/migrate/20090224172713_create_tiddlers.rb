class CreateTiddlers < ActiveRecord::Migration
  def self.up
    create_table :tiddlers do |t|
      t.string :title, :null => false
      t.text :text, :null => false
      t.string :tags
      t.string :bag, :null => false
      t.string :modifier, :null => false
      t.timestamps
    end
  end

  def self.down
    drop_table :tiddlers
  end
end