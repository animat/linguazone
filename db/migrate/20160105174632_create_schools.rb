class CreateSchools < ActiveRecord::Migration
  def change
    create_table :schools do |t|
    	t.string		:name
    	t.string 		:address
    	t.string 		:city
    	t.integer 		:state_id
    	t.string 		:zip
    	t.boolean 		:enabled
    	t.timestamps	:expired_at
    	t.timestamps null: false
    end
  end
end
