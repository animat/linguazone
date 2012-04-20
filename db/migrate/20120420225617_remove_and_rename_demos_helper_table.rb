class RemoveAndRenameDemosHelperTable < ActiveRecord::Migration
  def up
    remove_column :demos, :language_id
    remove_column :demos, :activity_id
    rename_column :demos, :lang_holder, :language_id
    rename_column :demos, :activ_holder, :activity_id
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
