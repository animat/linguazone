class CreateWordLists < ActiveRecord::Migration
  def self.up
    create_table :word_lists do |t|
      t.text :xml, :description
      t.references :language
      t.integer :created_by, :updated_by
      t.timestamps
    end
  end

  def self.down
    drop_table :word_lists
  end
end
