class Api::V2::CourseRegistrationsController < ApplicationController
  def create
    unless (params[:courseId])
      return missing_params
    end
    
    @auth = JSON.parse ActiveSupport::JSON.decode request.headers["Authorization"]
    @user = User.find_by_id_and_single_access_token(@auth["uid"], @auth["token"]) || nil
    return invalid_credentials unless @user
    
    @user.reset_single_access_token!
    # TODO: This header is not being intercepted by Angular properly... must be included in data response as "token"
    response.headers["X-AUTH-TOKEN"] = @user.single_access_token
    
    @cr = CourseRegistration.where(course_id: params[:courseId], user_id: @user.id).first_or_create!
    data = { token: @user.single_access_token, course_registration: @cr.as_json(:include => {:course => {:include => 
                                                                              {:user => {:include => :school}}}}) }
    render json: data, status: 201
  end
end