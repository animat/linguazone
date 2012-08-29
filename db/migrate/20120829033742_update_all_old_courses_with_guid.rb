class UpdateAllOldCoursesWithGuid < ActiveRecord::Migration
  def up
    @courses = Course.all
    @courses.each do |c|
      c.guid = rand(36**24).to_s(36)
      c.save
    end
  end
  
  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
