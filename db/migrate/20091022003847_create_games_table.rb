class CreateGamesTable < ActiveRecord::Migration
  def self.up
    create_table :languages do |t|
      t.string :language
    end
    
    create_table :templates do |t|
      t.text :xml
      t.string :name, :description
      t.integer :admin
      t.references :languages, :teachers
      t.timestamps
    end
    
    create_table :games do |t|
      t.text :xml
      t.string :description, :audio_ids
      t.references :templates, :languages, :teachers
      t.timestamps
    end
  end

  def self.down
  end
end
