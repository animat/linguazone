class CoursesController < ApplicationController
  filter_access_to :show, :attribute_check => true
  before_filter :check_expired

  def index
    @states      = State.national
    @intl_states = State.international
  end

  def show
    @course = Course.find(params[:id], :include => [:user, :school])
    @course_registrations = CourseRegistration.all(:conditions => ["course_id = ?", @course.id], :include => :user, :order => "users.last_name ASC")
    
    @showing_posts = @course.available_posts.find_all_by_hidden(0)
    @showing_word_lists = @course.available_word_lists.find_all_by_hidden(0)
    @showing_games = @course.available_games.find_all_by_hidden(0, :order => "ordering", :include => [:game, :activity])
    
    if @course.login_required
      unless is_student_for(@course) or is_teacher_for(@course)
        flash[:error] = "You are not registered for that class."
        redirect_to students_url
      end
    else
      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @course }
      end
    end
  end
  
  def feed
    @course = Course.find(params[:id], :include => [:user, :school])
    
    @showing_posts = Post.find_all_by_course_id(params[:id])
    @showing_word_lists = @course.available_word_lists.find_all_by_hidden(0)
    @showing_games = @course.available_games.find_all_by_hidden(0, :order => "ordering", :include => [:game, :activity])
    
    render :layout => false
    response.headers["Content-Type"] = "application/xml; charset=utf-8"
  end
  
  def update
    unless params[:code].nil? or params[:id].nil?
      @course = Course.find(params[:id])
      @course.code = params[:code]
      if params[:code].blank?
        @course.login_required = false
      else
        @course.login_required = true
      end
      if @course.save
        flash[:notice] = "Updated class settings"
      else
        flash[:error] = "Could not update class settings"
      end
    end
    redirect_to :action => "show", :id => @course.id
  end
  
  def add_post
    @course = Course.find(params[:id])
  end
  
  def add_game
    @course = Course.find(params[:id])
  end
  
  def add_list
    @course = Course.find(params[:id])
  end
  
  def order_games
    @course = Course.find(params[:id])
    @games = @course.available_games.find_all_by_hidden(0, :order => "ordering", :include => [:game, :activity])
  end
  
  def update_game_order
    params[:sortable_list].each_index do |i|
      item = AvailableGame.find(params[:sortable_list][i])
      item.ordering = i + 1
      item.save
    end
  end
  
  def search_hidden_games
    @course = Course.find(params['search']['course_id_equals'])
    @search = AvailableGame.search(params[:search])
    @available_games, @available_games_count = @search.all, @search.count
    @user_searching = true unless params[:search][:game_description_like].nil?
  end
  
  def search_hidden_word_lists
    @course = Course.find(params['search']['course_id_equals'])
    @search = AvailableWordList.search(params[:search])
    @available_word_lists, @available_word_lists_count = @search.all, @search.count
    @user_searching = true unless params[:search][:word_list_description_like].nil?
  end
  
  def search_hidden_posts
    @course = Course.find(params['search']['course_id_equals'])
    @search = AvailablePost.search(params[:search])
    @available_posts, @available_posts_count = @search.all, @search.count
    @user_searching = true unless params[:search][:post_title_like].nil?
  end
  
  def hide_game
    @showing_game = AvailableGame.find(params[:id])
    @showing_game.hidden = 1
    @showing_game.save
    
    render :update do |page|
      page.visual_effect :toggle_appear, dom_id(@showing_game)
    end
  end
  
  def hide_word_list
    @showing_word_list = AvailableWordList.find(params[:id])
    @showing_word_list.hidden = 1
    @showing_word_list.save
    
    render :update do |page|
      page.visual_effect :toggle_appear, dom_id(@showing_word_list)
    end
  end
  
  def hide_post
    @showing_post = AvailablePost.find(params[:id])
    @showing_post.hidden = 1
    @showing_post.save
    
    render :update do |page|
      page.visual_effect :toggle_appear, dom_id(@showing_post)
    end
  end
  
  def show_game
    @hidden_game = AvailableGame.find(params[:id])
    @hidden_game.hidden = 0
    @hidden_game.save
    
    render :update do |page|
      page.visual_effect :toggle_appear, dom_id(@hidden_game)
    end
  end
  
  def show_word_list
    @hidden_word_list = AvailableWordList.find(params[:id])
    @hidden_word_list.hidden = 0
    @hidden_word_list.save
    
    render :update do |page|
      page.visual_effect :toggle_appear, dom_id(@hidden_word_list)
    end
  end
  
  def show_post
    @hidden_post = AvailablePost.find(params[:id])
    @hidden_post.hidden = 0
    @hidden_post.save
    
    render :update do |page|
      page.visual_effect :toggle_appear, dom_id(@hidden_post)
    end
  end
  
  def permission_denied
    flash[:error] = "That class page is password-protected. Please login first."
    redirect_to :controller => "students", :action => "login"
  end
  
end
