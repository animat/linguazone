class Api::V2::UserSessionsController < ApplicationController
  def create
    unless (params[:email] && params[:password] && params[:role])
      return missing_params
    end
    
    @user = user_from_credentials || nil
    return invalid_credentials unless @user
    
    unless @user.role == params[:role]
      render json: {message: "You must be a #{params[:role]} to login."}, status: 422
      return
    end
    
    @user.reset_single_access_token!
    
    data = {
      info: @user,
      token: @user.single_access_token,
      uid: @user.id,
      provider: "email",
      expiry: 1.year.from_now
    }
    
    render json: {data: data}, status: 201
  end
  
  def destroy
    @auth = JSON.parse ActiveSupport::JSON.decode request.headers["Authorization"]
    @user = User.find_by_id_and_single_access_token(@auth["uid"], @auth["token"])
    return invalid_credentials unless @user
    @user.reset_single_access_token!
    render json: {}, status: 201
  end

  private
    def user_from_credentials
      if user = User.find_by_email(params[:email])
        if user.valid_password? params[:password]
          user
        end
      end
    end
end