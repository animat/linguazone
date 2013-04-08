class AddNodeOptionsToActivity < ActiveRecord::Migration
  def change
    add_column :activities, :node_options, :text
  end
end
