class RemoveTimestampsFromTemplates < ActiveRecord::Migration
	def up
		if ActiveRecord::Base.connection.table_exists? 'templates'
			remove_column :templates, :created_at
			remove_column :templates, :updated_at
		end
	end

	def down
		add_column :templates, :created_at, :timestamp
		add_column :templates, :updated_at, :timestamp
	end
end
