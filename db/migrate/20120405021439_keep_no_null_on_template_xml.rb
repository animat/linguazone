class KeepNoNullOnTemplateXml < ActiveRecord::Migration
  def up
    change_column :templates, :xml, :text, :null => false
  end

  def down
    change_column :templates, :xml, :text, :null => true
  end
end
