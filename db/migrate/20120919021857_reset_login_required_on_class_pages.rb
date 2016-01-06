class ResetLoginRequiredOnClassPages < ActiveRecord::Migration
  def up
    @courses = Course.all
    @counter = 0
    @courses.each do |c|
      tmp = c.login_required
      
      if c.code == ""
        c.login_required = false
      else
        c.login_required = true
      end
      
      if tmp != c.login_required
        puts "Corrected course ##{c.id}"
        @counter += 1
      end
      
      c.save
    end
    puts "Corrected #{@counter} courses total"
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
