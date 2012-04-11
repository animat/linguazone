ActiveAdmin.register User do
  
  filter :first_name
  filter :last_name
  filter :school
  filter :school_id, :as => :string
  filter :role, :as => :select, :collection => ["student", "teacher", "admin"]
  
  # TODO: Build scopes for admin interface
  #scope :all, :default => true
  #scope :trial
  
  index do
    column :id
    column :email
    column :first_name
    column :last_name
    column :role
    column :school
    column :subscription
    default_actions
  end
end
