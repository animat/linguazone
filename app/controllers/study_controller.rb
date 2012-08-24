class StudyController < ApplicationController
  before_filter :load_word_list
  
  def load_word_list
    @available_list = AvailableWordList.find(params[:id])
    @list = @available_list.word_list
  end
  
  def browse
    if current_user
      @sh = StudyHistory.new(:user_id => current_user.id, :word_list_id => @list.id, :study_type => "browse")
      @sh.submitted_at = Time.now
      @sh.user_ip_address = request.remote_ip
      @sh.save
      record_feed_item(@available_list.course.id)
    end
    doc = REXML::Document.new(@list.xml)
    @nodes = REXML::XPath.match(doc, "/gamedata/node")
  end

  def print
    @title = "Study word list: #{@list.description}"
    if current_user
      @sh = StudyHistory.new(:user_id => current_user.id, :word_list_id => @list.id, :study_type => "print")
      @sh.submitted_at = Time.now
      @sh.user_ip_address = request.remote_ip
      @sh.save
    end
    doc = REXML::Document.new(@list.xml)
    @nodes = REXML::XPath.match(doc, "/gamedata/node")
    
    render :layout => "print_word_list"
  end

  def practice
    if current_user
      @sh = StudyHistory.new(:user_id => current_user.id, :word_list_id => @list.id, :study_type => "practice")
      @sh.submitted_at = Time.now
      @sh.user_ip_address = request.remote_ip
      @sh.save
    end
  end

  def catch
    if current_user
      @sh = StudyHistory.new(:user_id => current_user.id, :word_list_id => @list.id, :study_type => "catch")
      @sh.submitted_at = Time.now
      @sh.user_ip_address = request.remote_ip
      @sh.save
    end
  end
  
  def stats
    @word_list = WordList.find(params[:id])
    @course = Course.find(params[:course])
    
    if @word_list.updated_by_id == current_user.id
      if params[:sort].nil?
        @study_histories = StudyHistory.find_all_by_word_list_id(params[:id])
        @registrations = CourseRegistration.all(:conditions => ["course_id = ?", @course.id])
      else
        if params[:sort] == "name"
          @scores = HighScore.all(:conditions => ["game_id = ?", params[:id]], :order => "user_id")
        elsif params[:sort] == "date"

        elsif params[:sort] == "score"

        end
      end
    else
      redirect_to :action => "show", :id => params[:id]
    end
  end

end
