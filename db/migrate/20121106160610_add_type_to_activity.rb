class AddTypeToActivity < ActiveRecord::Migration
  def change
    add_column :activities, :game_type, :string, :null => false, :default => "OneToOne"
  end
end
