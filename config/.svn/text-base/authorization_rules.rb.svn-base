authorization do
  
	role :admin do
	end
  
	role :teacher do
	  includes :guest
	  
		has_permission_on :teachers, :to => [:getting_started, :login, :index, :update]
		has_permission_on :posts, :to => [:new, :create, :show, :edit, :update, :delete, :destroy]
		# has_permission_on :posts, :to => [:new, :create, :edit, :update, :delete] do
		#       if_attribute :user_id => :is { course.user_id }
		#     end
		has_permission_on :customize, :to => [:new, :create, :edit, :update, :delete]
		has_permission_on :play, :to => [:stats] do
		  if_attribute :updated_by_id => is { user.id } # NOT WORKING!
	  end
		
		has_permission_on :courses do
      to :show, :add_game, :add_list, :search_hidden_games, :show_game, :hide_game
      if_attribute :user_id => is { user.id }
    end
	end
  
	role :student do
	  includes :guest
		has_permission_on :courses do
		  to :show
		  if_attribute :login_required => true #, and if they have access to that class page
		  # or if login_required => false
		end
		has_permission_on :students do
		  to :index, :register, :search_for_school, :select_school, :select_course, :enter_code, :auto_complete_for_school
	  end
	  has_permission_on :posts do
	    to :show
    end
		# Students can only see posts meant for classes in which they are registered
		# has_permission_on :posts do
		#       to :show
		#       if_attribute :registered_students contains => { user } 
		#     end
	end
	
	role :guest do
    has_permission_on :courses do
      to :show
      if_attribute :login_required => false
    end
    has_permission_on :teachers, :to => [:create, :new]
  end
  
end