class SetMoreGamesToHtml5Compatible < ActiveRecord::Migration
  def change
    @mag = Activity.find_by_name("Magnetized")
    @mag.html5_compatible = true
    @mag.save
    
    @at = Activity.find_by_name("Alphabet Tree")
    @at.html5_compatible = true
    @at.save
    
    @btb = Activity.find_by_name("Bathtub Bubbles")
    @btb.html5_compatible = true
    @btb.save
  end
end
