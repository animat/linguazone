class AddHtml5CompatibleFlagToActivity < ActiveRecord::Migration
  def change
    add_column :activities, :html5_compatible, :boolean, default: false
    
    @splat = Activity.find_by_name("Splat")
    @splat.html5_compatible = true
    @splat.save
    
    @fishing = Activity.find_by_name("Fishing")
    @fishing.html5_compatible = true
    @fishing.save
    
    @gg = Activity.find_by_name("Garden Grows")
    @gg.html5_compatible = true
    @gg.save
    
    @mantis = Activity.find_by_name("Mantis")
    @mantis.html5_compatible = true
    @mantis.save
    
    @lf = Activity.find_by_name("Leap Frog")
    @lf.html5_compatible = true
    @lf.save
    
    @thumper = Activity.find_by_name("Thumper")
    @thumper.html5_compatible = true
    @thumper.save
    
    @pp = Activity.find_by_name("Poker Pairs")
    @pp.html5_compatible = true
    @pp.save
  end
end
