# encoding: UTF-8
class StudyController < ApplicationController
  before_filter :load_word_list
  
  def load_word_list
    @al = AvailableWordList.find(params[:id])
    @list = @al.word_list
  end
  
  def browse
    if current_user
      @sh = StudyHistory.new(:user_id => current_user.id, :available_word_list_id => @al.id, :study_type => "browse")
      @sh.submitted_at = Time.now
      @sh.user_ip_address = request.remote_ip
      @sh.save
      record_feed_item(@al.course.id, @sh)
    end
    str = @list.xml
    doc = REXML::Document.new(str)
    #@nodes = REXML::XPath.match(doc, "/gamedata/node")
    @nodes = []
  end

  def print
    @title = "Study word list: #{@list.description}"
    if current_user
      @sh = StudyHistory.new(:user_id => current_user.id, :available_word_list_id => @al.id, :study_type => "print")
      @sh.submitted_at = Time.now
      @sh.user_ip_address = request.remote_ip
      @sh.save
      record_feed_item(@al.course.id, @sh)
    end
    doc = REXML::Document.new(@list.xml)
    @nodes = REXML::XPath.match(doc, "/gamedata/node")
    
    render :layout => "print_word_list"
  end

  def practice
    if current_user
      @sh = StudyHistory.new(:user_id => current_user.id, :available_word_list_id => @al.id, :study_type => "practice")
      @sh.submitted_at = Time.now
      @sh.user_ip_address = request.remote_ip
      @sh.save
      record_feed_item(@al.course.id, @sh)
    end
  end

  def catch
    if current_user
      @sh = StudyHistory.new(:user_id => current_user.id, :available_word_list_id => @list.id, :study_type => "catch")
      @sh.submitted_at = Time.now
      @sh.user_ip_address = request.remote_ip
      @sh.save
      record_feed_item(@al.course.id, @sh)
    end
  end
  
  def stats
    @course = @al.course
    
    if @list.updated_by_id == current_user.id
      if params[:sort].nil?
        @study_histories = StudyHistory.where(:available_word_list => @al.id)
        @registrations = CourseRegistration.where(:course_id => @course.id).includes(:user).order("users.last_name, users.first_name")
      else
        if params[:sort] == "name"
          @scores = StudyHistory.where(:conditions => ["available_word_list = ?", @al.id], :order => "user_id")
        elsif params[:sort] == "date"

        elsif params[:sort] == "score"

        end
      end
    else
      redirect_to :action => "show", :id => params[:id]
    end
  end

end
