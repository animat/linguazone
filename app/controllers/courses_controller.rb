class CoursesController < ApplicationController
  
  respond_to :html, :js, :xml

  def index
    @states      = State.national
    @intl_states = State.international
  end

  def show
    # TODO: Can these queries be optimized? e.g. the following query should get the course, the teacher, and teacher's school, subscription, etc
    @course = Course.find(params[:id])
    @showing_posts = AvailablePost.showing.on_course(@course.id).includes(:post).order("posts.updated_at DESC")
    @showing_word_lists = AvailableWordList.showing.on_course(@course.id).includes(:word_list).order("word_lists.updated_at DESC")
    @showing_games = AvailableGame.showing.on_course(@course.id).includes({:game => :activity}).order("ordering ASC, games.updated_at DESC")
    
    if @course.login_required
      unless is_student_for(@course) or is_teacher_for(@course)
        if current_user
          flash[:error] = "Please register to see the <strong>#{@course.name}</strong> class page.".html_safe
          session[:attempting_to_access_course_id] = @course.id
          redirect_to confirm_course_enter_code_students_path
        else
          flash[:error] = "Please login before accessing the <strong>#{@course.name}</strong> class page.".html_safe
          session[:attempting_to_access_course_id] = @course.id
          redirect_to login_students_url
        end
      end
    else
      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @course }
      end
    end
  end
  
  def feed
    @course = Course.find(params[:id], :include => :user)
    
    @showing_posts = AvailablePost.all(:conditions => ["available_posts.course_id = ? AND hidden = ?", @course.id, false], :include => :post,
                              :order => "posts.updated_at DESC")
    @showing_word_lists = AvailableWordList.all(:conditions => ["course_id = ? AND hidden = ?", @course.id, false], :include => :word_list,
                              :order => "word_lists.updated_at DESC")
    @showing_games = AvailableGame.all(:conditions => ["course_id = ? AND hidden = ?", @course.id, false], :include => :game, 
                              :order => "ordering ASC, games.updated_at DESC")
    
    response.headers["Content-Type"] = "application/xml; charset=utf-8"
    respond_to do |format|
      format.html { render "feed.xml" }
      format.xml { render "feed.xml" }
    end
  end
  
  def update
    unless params[:code].nil? or params[:id].nil?
      @course = Course.find(params[:id])
      if params[:login_required]
        if params[:code] == ""
          flash[:error] = "Please enter a class code in order to password-protect this class page."
          redirect_to course_path(@course) and return
        end
        @course.code = params[:code]
        @course.login_required = true
      else
        @course.code = ""
        @course.login_required = false
      end
      if @course.save
        flash[:success] = "Updated class settings"
      else
        flash[:error] = "Could not update class settings"
      end
    end
    redirect_to course_path(@course)
  end
  
  def send_invites
    @course = Course.find(params[:course_id])
    @emails = params[:invite_emails].split(",")
    @sent_count = 0
    @errors = ""
    if @emails[0] == "e.g. student@example.com"
      flash[:info] = "Please enter your students' email addresses to send invitations to join this class page."
      redirect_to new_course_course_registration_path(@course)
    else
      # TODO: I understand this is the foolish way to do this. But just how foolish is it? If classes are typically 10 - 40 kids?
      @emails.each do |e|
        email = e.strip
        unless email == ""
          if email =~ /\A[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]+\z/
            InvitationMailer.invite_student_to_course(email, @course).deliver
            @sent_count += 1
          else
            @errors << "#{email}<br />"
          end
        end
      end
      @invites = (@sent_count == 1) ? "invitation" : "invitations"
      flash[:success] = "Email #{@invites} (#{@sent_count} total) successfully sent" unless @sent_count == 0
      flash[:error] = "Could not send invitations to the following malformed addresses:<em><br />#{@errors}</em>".html_safe unless @errors == ""
      redirect_to course_path(@course)
    end
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
    @games = @course.available_games.find_all_by_hidden(false, :order => "ordering")
  end
  
  def update_game_order
    params[:item].each_index do |i|
      item = AvailableGame.find(params[:item][i])
      item.ordering = i + 1
      item.save
    end
    render :nothing => true
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
    @showing_game = AvailableGame.find(params[:available_game_id])
    @showing_game.hidden = true
    if @showing_game.save
      render :text => "Saved successfully"
    else
      render :text => "Failed"
    end
  end
  
  def hide_word_list
    @showing_word_list = AvailableWordList.find(params[:available_word_list_id])
    @showing_word_list.hidden = true
    if @showing_word_list.save
      render :text => "Saved successfully"
    else
      render :text => "Failed"
    end
  end
  
  def hide_post
    @showing_post = AvailablePost.find(params[:available_post_id])
    @showing_post.hidden = true
    if @showing_post.save
      render :text => "Saved successfully"
    else
      render :text => "Failed"
    end
  end
  
  def show_game
    @hidden_game = AvailableGame.find(params[:available_game_id])
    @hidden_game.hidden = false
    if @hidden_game.save
      render :text => "Saved successfully"
    else
      render :text => "Failed"
    end
  end
  
  def show_word_list
    @hidden_word_list = AvailableWordList.find(params[:available_word_list_id])
    @hidden_word_list.hidden = false
    if @hidden_word_list.save
      render :text => "Saved successfully"
    else
      render :text => "Failed"
    end
  end
  
  def show_post
    @hidden_post = AvailablePost.find(params[:available_post_id])
    @hidden_post.hidden = false
    if @hidden_post.save
      render :text => "Saved successfully"
    else
      render :text => "Failed"
    end
  end
  
  def permission_denied
    flash[:error] = "That class page is password-protected. Please login first."
    redirect_to :controller => "students", :action => "login"
  end
  
end
