class PasswordResetsController < ApplicationController  
  before_filter :load_user_using_perishable_token, :only => [:edit, :update]
  respond_to :html, :js
  
  def new  
    render  
  end  
  
  def create  
    @user = User.find_by_email(params[:email])
    if @user
      begin
        @user.deliver_password_reset_instructions!  
        @success = true
        respond_to do |format|
          format.html { 
            flash[:notice] = "Instructions to reset your password have been emailed to you. Please check your email."  
            redirect_to root_url 
          }
          format.js { render }
        end
      rescue
        respond_to do |format|
          format.html {
            flash[:error] = "Sorry, we need a valid email address to reset your password.<br />Please contact us for assistance."
            redirect_to root_url
          }
          format.js { render }
        end
      end
    else  
      flash[:error] = "No user was found with that email address."  
      render :action => :new  
    end  
  end  

  def edit  
    render  
  end  
 
  def update  
    @user.password = params[:user][:password] 
    if @user.save  
      flash[:success] = "Password successfully updated!"
      if @user.role == "student"  
        redirect_to :controller => "students"
      else
        redirect_to :controller => "teachers"
      end
    else  
      render :action => :edit  
    end  
  end  
 
  private  
    def load_user_using_perishable_token  
      @user = User.find_using_perishable_token(params[:id])  
    unless @user  
      flash[:error] = "We're sorry, but we could not locate your account. " +  
      "If you are having issues try copying and pasting the URL " +  
      "from your email into your browser or restarting the " +  
      "reset password process."  
      redirect_to root_url  
    end  
  end
end