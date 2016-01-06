class UpdateAllOldCoursesWithGuid < ActiveRecord::Migration
  def up
    @courses = Course.all
    @courses.each do |c|
      c.guid = SecureRandom.base64(36)
      c.save
    end
  end
  
  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
