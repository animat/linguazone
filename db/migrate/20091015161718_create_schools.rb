class CreateSchools < ActiveRecord::Migration
  def self.up
    create_table :schools do |t|
      t.string :name
      t.string :address
      t.string :city
      t.integer :zip
      t.integer :pin
      t.date :expire_at

      t.timestamps
    end
  end

  def self.down
    drop_table :schools
  end
end
