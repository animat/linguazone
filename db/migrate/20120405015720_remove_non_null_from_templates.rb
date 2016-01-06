class RemoveNonNullFromTemplates < ActiveRecord::Migration
  def up
    change_column :templates, :xml, :text, :null => true
    change_column :templates, :name, :string, :null => true
    change_column :templates, :description, :text, :null => true
  end

  def down
    change_column :templates, :xml, :text, :null => false
    change_column :templates, :name, :string, :null => false
    change_column :templates, :description, :string, :null => false
  end
end
