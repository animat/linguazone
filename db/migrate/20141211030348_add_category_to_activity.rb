class AddCategoryToActivity < ActiveRecord::Migration
  def change
    add_column :activities, :category, :string, :null => :false, :default => "Unscramble"
  end
end
