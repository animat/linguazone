class DestroyAllStudentAccounts < ActiveRecord::Migration
  def up
    puts "*"*50
    @total_users = User.count(:conditions => "role = 'student'")
    puts "Current students count: #{@total_users}"
    @students = User.where(:role => "student")
    @students.each do |s|
      s.destroy
    end
    @total_users = User.count(:conditions => "role = 'student'")
    puts "Updated students count: #{@total_users}"
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
