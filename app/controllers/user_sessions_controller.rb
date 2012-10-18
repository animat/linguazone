class UserSessionsController < ApplicationController
  
  def new
    @user_session = UserSession.new
  end
  
  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      if params[:user_session][:role] == "teacher"
        redirect_to :controller => "teachers", :action => "index"
      elsif params[:user_session][:role] == "student"
        redirect_to :controller => "students", :action => "index"
      elsif params[:user_session][:role] == "artist"
        redirect_to :controller => "media", :action => "index"
      end
    else
      flash[:error] = "There was an error logging in. Please try again."
      if params[:user_session][:role] == "teacher"
        redirect_to :controller => "teachers", :action => "login"
      elsif params[:user_session][:role] == "student"
        redirect_to :controller => "students", :action => "login"
      end
    end
  end
  
  def destroy
    session.delete :course_guid
    session.delete :user_email
    @user_session = UserSession.find
    @user_session.destroy unless @user_session.nil?
    redirect_to root_url
  end
  
end
