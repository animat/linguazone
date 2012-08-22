class AuthenticationsController < ApplicationController
  def index
    @authentications = current_user.authentications if current_user
  end
  
  def create
    omniauth = request.env["omniauth.auth"]
    authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
    if authentication
      # This authentication is currently in the database. Log user in (if needed) and redirect to students_path
      unless current_user
        UserSession.create(authentication.user)
      end
      flash[:success] = "Authentication successful."
      redirect_to students_path
    elsif current_user
      # The user is currently logged in and is creating a new authentication. Save this authentication to the database.
      current_user.authentications.create!(:provider => omniauth['provider'], :uid => omniauth['uid'])
      flash[:success] = "Authentication successful."
      redirect_to students_path
    else
      # This is a new authentication from an anonymous user. Prompt user to make a new student account.
      @user = User.new
      @user.apply_omniauth(omniauth)
      session[:omniauth] = omniauth.except("extra")
      redirect_to new_student_path
    end
  end
  
  def cancel
    session['omniauth'] = nil
    session.delete :omniauth
    flash[:notice] = "Sign up process canceled."
    redirect_to root_path
  end
  
  def destroy
    @authentication = current_user.authentications.find(params[:id])
    if current_user.authentications.length > 1 or !current_user.has_generic_lz_email?
      @authentication.destroy
      flash[:notice] = "Successfully destroyed #{@authentication.provider.titleize} authentication."
    else
      flash[:error] = "Sorry! We cannot delete that authentication. You need at least one way to login to LinguaZone."
    end
    redirect_to students_path
  end
end
