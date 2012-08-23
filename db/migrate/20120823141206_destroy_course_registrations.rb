class DestroyCourseRegistrations < ActiveRecord::Migration
  def up
    puts "*"*50
    @regs_count = CourseRegistration.count
    puts "Current registration count: #{@regs_count}"
    @regs = CourseRegistration.all
    @regs.each do |cr|
      cr.destroy
    end
    @regs_count = CourseRegistration.count
    puts "Updated registration count: #{@regs_count}"
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
