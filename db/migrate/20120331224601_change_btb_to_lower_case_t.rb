class ChangeBtbToLowerCaseT < ActiveRecord::Migration
  def up
    Activity.find_by_name("Bath Tub Bubbles").update_attribute :name, "Bathtub Bubbles"
    Activity.find_by_swf("bathTubBubbles").update_attribute :swf, "bathtubBubbles"
  end

  def down
    Activity.find_by_name("Bathtub Bubbles").update_attribute :name, "Bath Tub Bubbles"
    Activity.find_by_swf("bathtubBubbles").update_attribute :swf, "bathTubBubbles"
  end
end
