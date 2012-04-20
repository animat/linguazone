class ConvertDemoAssociationsAgain < ActiveRecord::Migration
  def up
    add_column :demos, :lang_holder, :int
    add_column :demos, :activ_holder, :int
    
    demos = Demo.all
    demos.each do |d|
      d.lang_holder = d.language_id.to_i
      d.activ_holder = d.activity_id.to_i
      d.save
    end
    
  end

  def down
    remove_column :demos, :lang_holder
    remove_column :demos, :activ_holder
  end
end
