class Api::V2::UserSessionsController < ApplicationController
  def create
    unless (params[:email] && params[:password])
      return missing_params
    end
    
    @user = user_from_credentials || nil
    return invalid_credentials unless @user
    
    @user.reset_single_access_token!
    
    data = {
      user_id: @user.id,
      auth_token: @user.single_access_token
    }
    
    render json: data, status: 201
  end

  private
    def user_from_credentials
      if user = User.find_by_email(params[:email])
        if user.valid_password? params[:password]
          user
        end
      end
    end

    def missing_params
      render json: {}, status: 400
    end

    def invalid_credentials
      render json: {}, status: 401
    end
      
end